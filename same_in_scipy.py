"""
Same manipulations with the same data but in SciPy
"""

# First we input the same data manually

import matplotlib.pyplot as plt

t = [0, 1, 2, 3]
x = [0.2, 0.4, 0.6, 0.8]
y = [0.25, 0.55, 0.45, 0.7]

a = 0.6; b = 0.2       # wild guess parameters of the linear model

plt.axis('square')
plt.axis([0, 1, 0, 1])
plt.plot(x, y, 'ro')

plt.show()

# print(t, x, y, a, b)
