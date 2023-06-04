import networkx as nx
import matplotlib.pyplot as plt

# create a sample graph
G = nx.Graph()
G.add_edges_from([(1,2),(2,3),(3,4),(4,1)])

# set edge weights
weights = {(1,2): 0.5, (2,3): 0.2, (3,4): 0.8, (4,1): 0.4, (1,4): 0.2}

# get edge colors based on weights
colors = [weights[e] for e in G.edges()]

# draw the graph with highlighted edges
nx.draw(G, with_labels=True, edge_color=colors, width=4, edge_cmap=plt.cm.Blues)
plt.show()

