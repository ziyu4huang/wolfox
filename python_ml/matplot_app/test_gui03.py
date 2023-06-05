import matplotlib.pyplot as plt
from matplotlib.patches import Rectangle
from matplotlib.widgets import Button

class ShapeEditor:
    def __init__(self):
        self.fig, self.ax = plt.subplots()
        self.fig.subplots_adjust(bottom=0.2)  # make space for the button

        # Add several rectangles to represent components
        self.rectangles = [
            Rectangle((0.1, 0.1), 0.1, 0.1, fill=True, color='blue'),
            Rectangle((0.3, 0.3), 0.1, 0.1, fill=True, color='green'),
            Rectangle((0.5, 0.5), 0.1, 0.1, fill=True, color='red'),
        ]
        for rect in self.rectangles:
            self.ax.add_patch(rect)

        self.selected_rectangle = None

        # Connect the mouse button press, release and motion events
        self.fig.canvas.mpl_connect('button_press_event', self.on_press)
        self.fig.canvas.mpl_connect('button_release_event', self.on_release)
        self.fig.canvas.mpl_connect('motion_notify_event', self.on_motion)

        # Add a delete button
        delete_button_ax = plt.axes([0.8, 0.05, 0.1, 0.075])
        self.delete_button = Button(delete_button_ax, 'Delete')
        self.delete_button.on_clicked(self.delete_selected)

    def on_press(self, event):
        # Check if the mouse pointer is inside any of the rectangles
        for rect in self.rectangles:
            if rect.contains(event)[0]:
                # If it is, select the rectangle and change its color
                self.selected_rectangle = rect
                rect.set_color('yellow')
                self.fig.canvas.draw()

    def on_release(self, event):
        # Deselect the rectangle and change its color back
        if self.selected_rectangle is not None:
            self.selected_rectangle.set_color('blue')
            self.selected_rectangle = None
            self.fig.canvas.draw()

    def on_motion(self, event):
        # If a rectangle is selected and the mouse is inside the axes, move the rectangle
        if self.selected_rectangle is not None and event.inaxes is not None:
            self.selected_rectangle.set_xy((event.xdata, event.ydata))
            self.fig.canvas.draw()

    def delete_selected(self, event):
        # If a rectangle is selected, remove it
        if self.selected_rectangle is not None:
            self.rectangles.remove(self.selected_rectangle)
            self.selected_rectangle.remove()
            self.selected_rectangle = None
            self.fig.canvas.draw()

    def show(self):
        plt.show()

# Create and show the shape editor
editor = ShapeEditor()
editor.show()
