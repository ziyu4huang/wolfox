import numpy as np
import networkx as nx
import matplotlib.pyplot as plt
from karateclub.node_embedding.neighbourhood.deepwalk import DeepWalk

G = nx.random_tree(40)
plt.figure(1)

pos = nx.spring_layout(G, iterations=13, seed=5)
nx.draw_networkx(G, pos, with_labels=True)

deepwalk = DeepWalk(dimensions=2)

deepwalk.fit(G)
embedding = deepwalk.get_embedding()

plt.figure(2)
plt.scatter(embedding[:,0], embedding[:,1])
plt.show()