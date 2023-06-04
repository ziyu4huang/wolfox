import networkx as nx
import matplotlib.pyplot as plt

# create an example graph
G = nx.DiGraph()
G.add_nodes_from([1, 2, 3])
G.add_weighted_edges_from([(1, 2, 0.5), (2, 3, 0.8)])

# draw the graph
pos = nx.spring_layout(G)
nx.draw(G, pos, with_labels=True, font_weight='bold')

# highlight the weight of edge (1, 2)
edge_labels = {edge: str(weight) for edge, weight in nx.get_edge_attributes(G, 'weight').items()}
edge_colors = ['red' if edge == (1, 2) else 'black' for edge in G.edges()]
nx.draw_networkx_edge_labels(G, pos, edge_labels=edge_labels)
nx.draw(G, pos, with_labels=True, font_weight='bold', edge_color=edge_colors)

plt.show()
