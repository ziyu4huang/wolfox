import networkx as nx
import matplotlib.pyplot as plt

from networkx.algorithms.community import kernighan_lin as alg
# ref https://networkx.org/documentation/latest/reference/algorithms/generated/networkx.algorithms.community.kernighan_lin.kernighan_lin_bisection.html#networkx.algorithms.community.kernighan_lin.kernighan_lin_bisection
# paper : https://www.semanticscholar.org/paper/An-Efficient-Heuristic-Procedure-for-Partitioning-S.-Lin/c7f137fcc9e8bb252ccb90f51ab28a6cdbec0cb4?utm_source=direct_link

G = nx.Graph()
G.add_edges_from([(1, 2), (1, 3), (2, 3), (3, 4), (3, 5), (4, 5), (4, 6), (5, 6), (5, 7), (6, 7)])

A, B = alg.kernighan_lin_bisection(G)

print("Set A:", A)
print("Set B:", B)


pos = nx.spring_layout(G)
nx.draw(G, pos, with_labels=True)
nx.draw_networkx_nodes(G, pos, nodelist=A, node_color='r')
nx.draw_networkx_nodes(G, pos, nodelist=B, node_color='b')
plt.show()





