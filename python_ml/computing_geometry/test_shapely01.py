import matplotlib.pyplot as plt
from shapely.geometry import Polygon
from matplotlib.patches import Polygon as mpl_polygon

# Define the rectangles
rect1 = Polygon([(0, 0), (0, 4), (4, 4), (4, 0)])
rect2 = Polygon([(2, 2), (2, 6), (6, 6), (6, 2)])

# Perform union operation
union = rect1.union(rect2)

# Create the Matplotlib figure and axes
fig, ax1 = plt.subplots()

if True:
# Plot the rectangles
    rect1_patch = mpl_polygon(rect1.exterior.coords, alpha=0.5, fc='blue', ec='black')
    rect2_patch = mpl_polygon(rect2.exterior.coords, alpha=0.5, fc='green', ec='black')
    ax1.add_patch(rect1_patch)
    ax1.add_patch(rect2_patch)
    ax1.set_xlim(-1, 7)
    ax1.set_ylim(-1, 7)
    ax1.set_aspect('equal')
    ax1.set_xlabel('X')
    ax1.set_ylabel('Y')

if True :
    fig, ax2 = plt.subplots()
    # Plot the union polygon
    union_patch = mpl_polygon(union.exterior.coords, alpha=0.5, fc='red', ec='black')
    ax2.add_patch(union_patch)

    # Set axis limits and labels
    ax2.set_xlim(-1, 7)
    ax2.set_ylim(-1, 7)
    ax2.set_aspect('equal')
    ax2.set_xlabel('X')
    ax2.set_ylabel('Y')

# Show the plot
plt.show()

