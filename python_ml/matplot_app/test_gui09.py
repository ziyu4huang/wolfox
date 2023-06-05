import tkinter as tk
from matplotlib.figure import Figure
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg
from matplotlib.widgets import RectangleSelector
import matplotlib.pyplot as plt
import numpy as np

class RectangleProperties(tk.Toplevel):
    def __init__(self, master=None):
        super().__init__(master)
        self.title("Rectangle Properties")
        self.geometry("200x200")
        self.create_widgets()

    def create_widgets(self):
        self.listbox = tk.Listbox(self)
        self.listbox.pack(fill=tk.BOTH, expand=1)

    def update_properties(self, rectangles):
        self.listbox.delete(0, tk.END)
        for rect in rectangles:
            self.listbox.insert(tk.END, f"Rectangle: {rect.get_label()}")
            self.listbox.insert(tk.END, f"  Width: {rect.get_width()}")
            self.listbox.insert(tk.END, f"  Height: {rect.get_height()}")
            self.listbox.insert(tk.END, "")

class Application(tk.Tk):
    def __init__(self):
        super().__init__()
        self.title("Rectangle Selector")
        self.geometry("500x500")
        self.create_widgets()
        self.rectangles = []
        self.selected_rectangles = []
        self.create_rectangle = False

    def create_widgets(self):
        fig = Figure(figsize=(5, 5), dpi=100)
        self.ax = fig.add_subplot(111)
        self.canvas = FigureCanvasTkAgg(fig, master=self)
        self.canvas.draw()
        self.canvas.get_tk_widget().pack(side=tk.TOP, fill=tk.BOTH, expand=1)

        self.rs = RectangleSelector(self.ax, self.line_select_callback,
                                    drawtype='box', useblit=True,
                                    button=[1, 3],  # don't use middle button
                                    minspanx=5, minspany=5,
                                    spancoords='pixels',
                                    interactive=True)

        self.canvas.mpl_connect("key_press_event", self.toggle_selector)

        self.create_button = tk.Button(self, text="Create", command=self.toggle_create)
        self.create_button.pack(side=tk.BOTTOM)

    def line_select_callback(self, eclick, erelease):
        'eclick and erelease are the press and release events'
        if not self.create_rectangle:
            return

        x1, y1 = eclick.xdata, eclick.ydata
        x2, y2 = erelease.xdata, erelease.ydata
        rect = plt.Rectangle((min(x1,x2),min(y1,y2)), np.abs(x1-x2), np.abs(y1-y2))
        self.ax.add_patch(rect)
        self.rectangles.append(rect)
        self.canvas.draw()

    def toggle_selector(self, event):
        print(' Key pressed.')
        if event.key == 't':
            if self.rs.active:
                print(' RectangleSelector deactivated.')
                self.rs.set_active(False)
            else:
                print(' RectangleSelector activated.')
                self.rs.set_active(True)
        if event.key == 'Q':
            self.selected_rectangles = self.rectangles
            self.show_properties()

    def toggle_create(self):
        self.create_rectangle = not self.create_rectangle

    def show_properties(self):
        properties_window = RectangleProperties(self)
        properties_window.update_properties(self.selected_rectangles)

app = Application()
app.mainloop()
