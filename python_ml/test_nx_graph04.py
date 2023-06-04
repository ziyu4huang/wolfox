

import networkx as nx

'''
To normalize the edge weights of a network to a range of 0 to 100, you can use min-max normalization. 
Here's a step-by-step guide on how to perform this normalization:

1. Find the minimum and maximum values of the edge weights in the network.
2. Subtract the minimum value from each weight to shift the range to start from 0.
3. Divide each weight by the difference between the maximum and minimum values to scale the range to 0 to 1.
4. Multiply each weight by 100 to scale the range to 0 to 100.

Here's an example code snippet using NetworkX library in Python to perform the normalization:

In this example, we create a network `G` with weighted edges. We then calculate the minimum and maximum edge 
weights using a list comprehension. Next, we iterate through the edges of the network and perform the 
min-max normalization by subtracting the minimum weight, dividing by the range, 
and multiplying by 100. We store the normalized weights in a new attribute called `normalized_weight`. 
Finally, we print the normalized weights for each edge.

Note that this code assumes the edge weights are numeric values. If your edge weights are non-numeric 
or have different data types, you may need to adjust the normalization procedure accordingly.

'''

# Create a network with weighted edges
G = nx.Graph()
G.add_edge(1, 2, weight=5)
G.add_edge(2, 3, weight=10)
G.add_edge(3, 4, weight=20)
G.add_edge(4, 1, weight=15)

# Find the minimum and maximum edge weights
weights = [data['weight'] for _, _, data in G.edges(data=True)]
min_weight = min(weights)
max_weight = max(weights)

# Normalize the edge weights to the range of 0 to 100
for u, v, data in G.edges(data=True):
    normalized_weight = 100 * (data['weight'] - min_weight) / (max_weight - min_weight)
    data['normalized_weight'] = normalized_weight

# Print the normalized edge weights
for u, v, data in G.edges(data=True):
    print(f"Edge ({u}, {v}): Normalized Weight = {data['normalized_weight']}")



# Sort the edges based on their weight
sorted_edges = sorted(G.edges(data=True), key=lambda x: x[2]['weight'], reverse=True)

# Iterate through the edges in order of weight
for u, v, data in sorted_edges:
    weight = data['weight']
    print(f"Edge ({u}, {v}): Weight = {weight}")
