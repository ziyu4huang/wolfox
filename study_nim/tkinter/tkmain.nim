import nimpy

# Import Python libraries
let plt = pyImport("matplotlib.pyplot")
let tk = pyImport("tkinter")
let FigureCanvasTkAgg = pyImport("matplotlib.backends.backend_tkagg").FigureCanvasTkAgg

let py = pyBuiltinsModule()

# Function to plot using Matplotlib
proc plot(): PyObject {.exportpy.} =
  let fig, ax = plt.subplots()
  #let x = py.list([0, 1, 2, 3, 4])
  let x = @[0, 1, 2, 3, 4]
  let y = @[0, 1, 4, 9, 16]
  ax.plot(x, y)
  ax.set_title("Plot of y = x^2")
  ax.set_xlabel("x")
  ax.set_ylabel("y")
  return fig

# Create Tkinter window
let root = tk.Tk()
root.title("Tkinter and Matplotlib in Nim")

# Add button to trigger plot
let button = tk.Button(root, text="Plot", command=plot)
button.pack()

# Embed Matplotlib plot in Tkinter window
let fig = plot()
let canvas = FigureCanvasTkAgg(fig, master=root)
canvas.draw()
canvas.get_tk_widget().pack()

# Start Tkinter event loop
root.mainloop()

