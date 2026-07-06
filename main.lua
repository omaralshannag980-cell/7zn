"""
ترفيكسا - Trvexa Anti-AFK
واجهة رسومية بسيطة تمنع طردك من الألعاب/البرامج بسبب عدم الحركة،
عن طريق محاكاة ضغطة مفتاح غير مؤثرة (Shift) كل فترة زمنية محددة.
"""

import tkinter as tk
from tkinter import font as tkfont
import threading
import time
import random

# محاولة استيراد مكتبة محاكاة الضغطات (اختيارية)
try:
    import pyautogui
    HAS_PYAUTOGUI = True
except ImportError:
    HAS_PYAUTOGUI = False

USERNAME = "9z_e.1"

# ---------------- الألوان ----------------
BG_DARK = "#0d0221"
BG_PANEL = "#1a0b2e"
ACCENT_PURPLE = "#7b2ff7"
ACCENT_GOLD = "#f5c518"
ACCENT_PINK = "#f72585"
TEXT_LIGHT = "#f1f1f1"
TEXT_MUTED = "#a89bd6"
GREEN_ON = "#39ff14"
RED_OFF = "#ff3b3b"


class TrvexaApp:
    def __init__(self, root):
        self.root = root
        self.running = False
        self.interval = tk.IntVar(value=30)  # كل كم ثانية
        self.thread = None
        self.session_start = None
        self.timer_job = None

        root.title("ترفيكسا | Trvexa Anti-AFK")
        root.geometry("420x480")
        root.configure(bg=BG_DARK)
        root.resizable(False, False)

        title_font = tkfont.Font(family="Segoe UI", size=22, weight="bold")
        sub_font = tkfont.Font(family="Segoe UI", size=10)
        user_font = tkfont.Font(family="Consolas", size=13, weight="bold")

        # ---- العنوان ----
        title_lbl = tk.Label(
            root, text="⚡ ترفيكسا ⚡", font=title_font,
            bg=BG_DARK, fg=ACCENT_GOLD
        )
        title_lbl.pack(pady=(25, 0))

        subtitle_lbl = tk.Label(
            root, text="Trvexa Anti-AFK System",
            font=sub_font, bg=BG_DARK, fg=TEXT_MUTED
        )
        subtitle_lbl.pack(pady=(0, 15))

        # ---- اسم المستخدم القابل للنسخ ----
        user_frame = tk.Frame(root, bg=BG_PANEL, highlightbackground=ACCENT_PURPLE, highlightthickness=2)
        user_frame.pack(pady=5)

        user_lbl = tk.Label(
            user_frame, text=f"👤 {USERNAME}",
            font=user_font, bg=BG_PANEL, fg=ACCENT_PINK,
            padx=15, pady=8, cursor="hand2"
        )
        user_lbl.pack()
        user_lbl.bind("<Button-1>", self.copy_username)

        self.copy_hint = tk.Label(
            root, text="اضغط على الاسم لنسخه",
            font=("Segoe UI", 8), bg=BG_DARK, fg=TEXT_MUTED
        )
        self.copy_hint.pack(pady=(2, 20))

        # ---- لوحة التحكم ----
        panel = tk.Frame(root, bg=BG_PANEL, highlightbackground=ACCENT_PURPLE, highlightthickness=1)
        panel.pack(padx=25, pady=5, fill="x")

        interval_lbl = tk.Label(
            panel, text="الفاصل الزمني (بالثواني):",
            font=("Segoe UI", 10), bg=BG_PANEL, fg=TEXT_LIGHT
        )
        interval_lbl.pack(pady=(15, 5))

        interval_spin = tk.Spinbox(
            panel, from_=5, to=600, textvariable=self.interval,
            width=8, font=("Segoe UI", 11), justify="center",
            bg=BG_DARK, fg=ACCENT_GOLD, insertbackground=ACCENT_GOLD,
            buttonbackground=ACCENT_PURPLE, relief="flat"
        )
        interval_spin.pack(pady=(0, 15))

        # ---- الحالة ----
        self.status_lbl = tk.Label(
            panel, text="● متوقف", font=("Segoe UI", 12, "bold"),
            bg=BG_PANEL, fg=RED_OFF
        )
        self.status_lbl.pack(pady=(0, 10))

        self.countdown_lbl = tk.Label(
            panel, text="", font=("Segoe UI", 9),
            bg=BG_PANEL, fg=TEXT_MUTED
        )
        self.countdown_lbl.pack(pady=(0, 5))

        self.timer_lbl = tk.Label(
            panel, text="⏱ الوقت الكلي: 00:00:00",
            font=("Segoe UI", 11, "bold"), bg=BG_PANEL, fg=ACCENT_GOLD
        )
        self.timer_lbl.pack(pady=(0, 15))

        # ---- زر التشغيل ----
        self.toggle_btn = tk.Button(
            root, text="▶  تشغيل", font=("Segoe UI", 13, "bold"),
            bg=ACCENT_PURPLE, fg="white", activebackground=ACCENT_PINK,
            activeforeground="white", relief="flat", padx=30, pady=10,
            cursor="hand2", command=self.toggle
        )
        self.toggle_btn.pack(pady=25)

        # ---- تنبيه المكتبة ----
        if not HAS_PYAUTOGUI:
            warn_lbl = tk.Label(
                root,
                text="⚠ لتفعيل المحاكاة الفعلية ثبّت المكتبة:\npip install pyautogui",
                font=("Segoe UI", 9), bg=BG_DARK, fg=ACCENT_GOLD, justify="center"
            )
            warn_lbl.pack(pady=(0, 10))

        footer = tk.Label(
            root, text="Trvexa © 2026", font=("Segoe UI", 8),
            bg=BG_DARK, fg=TEXT_MUTED
        )
        footer.pack(side="bottom", pady=10)

    def copy_username(self, event=None):
        self.root.clipboard_clear()
        self.root.clipboard_append(USERNAME)
        self.root.update()
        original = self.copy_hint.cget("text")
        self.copy_hint.config(text="✔ تم النسخ!", fg=GREEN_ON)
        self.root.after(1500, lambda: self.copy_hint.config(text=original, fg=TEXT_MUTED))

    def toggle(self):
        if not self.running:
            self.running = True
            self.session_start = time.time()
            self.status_lbl.config(text="● يعمل الآن", fg=GREEN_ON)
            self.toggle_btn.config(text="■  إيقاف", bg=ACCENT_PINK)
            self.thread = threading.Thread(target=self.anti_afk_loop, daemon=True)
            self.thread.start()
            self.update_timer()
        else:
            self.running = False
            self.status_lbl.config(text="● متوقف", fg=RED_OFF)
            self.toggle_btn.config(text="▶  تشغيل", bg=ACCENT_PURPLE)
            self.countdown_lbl.config(text="")
            if self.timer_job:
                self.root.after_cancel(self.timer_job)
                self.timer_job = None
            self.timer_lbl.config(text="⏱ توقف عند: " + self.timer_lbl.cget("text").split(": ")[1])

    def update_timer(self):
        if not self.running or self.session_start is None:
            return
        elapsed = int(time.time() - self.session_start)
        hours, rem = divmod(elapsed, 3600)
        minutes, seconds = divmod(rem, 60)
        self.timer_lbl.config(text=f"⏱ الوقت الكلي: {hours:02d}:{minutes:02d}:{seconds:02d}")
        self.timer_job = self.root.after(1000, self.update_timer)

    def anti_afk_loop(self):
        while self.running:
            wait = self.interval.get()
            for remaining in range(wait, 0, -1):
                if not self.running:
                    return
                self.countdown_lbl.config(text=f"الضغطة القادمة خلال {remaining} ث")
                time.sleep(1)

            if HAS_PYAUTOGUI:
                try:
                    pyautogui.press("shift")
                except Exception:
                    pass
            # اهتزاز بسيط للماوس كبديل إضافي إذا توفرت المكتبة
            if HAS_PYAUTOGUI:
                try:
                    x, y = pyautogui.position()
                    pyautogui.moveTo(x + random.choice([-1, 1]), y, duration=0.1)
                    pyautogui.moveTo(x, y, duration=0.1)
                except Exception:
                    pass


if __name__ == "__main__":
    root = tk.Tk()
    app = TrvexaApp(root)
    root.mainloop()
