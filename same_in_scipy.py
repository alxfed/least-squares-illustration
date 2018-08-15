"""
Same manipulations with the same data but in SciPy
"""

# First we input the same data manually

import matplotlib.pyplot as plt
from matplotlib.collections import PatchCollection
from matplotlib.patches import Rectangle
import numpy as np

t = [0, 1, 2, 3]         # I probably don't need that.
x = np.array([0.2, 0.4, 0.6, 0.8])
y = np.array([0.25, 0.55, 0.45, 0.8])
err = np.array([[0.1, 0.15, 0.25, 0.1], [0.2, 0.35, 0.25, 0.15]])  # relative to the points

a = 0.6; b = 0.2         # wild guess parameters of the linear model

plt.axis('square')       # aspect ratio of the plot
plt.axis([0, 1, 0, 1])   # rigid axes
plt.xlabel('X')
plt.ylabel('Y')
# plt.plot(x, y, 'ro')   # 'ro' stands for 'red' 'o' s
plt.errorbar(x, y, yerr= err,
             fmt= 'ro',
             ecolor= 'black',
             elinewidth= 0.7,
             capsize= 1.5,
             capthick= 0.7)

xl = np.arange(0.01, 1, 0.01)
plt.plot(xl, a*xl + b,
             color='blue',
             linewidth=0.8)

def make_squares(ax, xdata, ydata, xerror, yerror, facecolor='gray',
                     edgecolor='black', alpha=0.5):

    # Create list for all the error patches
    squares = []

    # Loop over data points; create box from errors at each point
    for x, y, xe, ye in zip(xdata, ydata, xerror.T, yerror.T):
        rect = Rectangle((x - xe[0], y - ye[0]), xe.sum(), ye.sum())
        squares.append(rect)

    # Create patch collection with specified colour/alpha
    pc = PatchCollection(squares, facecolor=facecolor, alpha=alpha,
                         edgecolor=edgecolor)

    # Add collection to axes
    ax.add_collection(pc)

    return ax

# Create figure and axes
fig, ax = plt.subplots(1)

# Call function to create error boxes
_ = make_squares(ax, x, y, xerr, yerr)

plt.show()

# print(t, x, y, a, b)
