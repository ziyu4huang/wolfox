import networkx as nx
import random
import os
import sys
import numpy as np
import scipy.sparse.linalg as sla

def create_network(N, j, k):
    G = nx.Graph()
    
    # Create N nodes
    nodes = range(N)
    G.add_nodes_from(nodes)
    
    for node in nodes:
        # Generate random number of edges for the node
        num_edges = random.randint(j, k)
        
        # Randomly select nodes to connect to
        other_nodes = list(nodes)
        other_nodes.remove(node)  # Remove current node from the list
        
        # Connect to the selected nodes
        selected_nodes = random.sample(other_nodes, num_edges)
        edges = [(node, selected_node) for selected_node in selected_nodes]
        G.add_edges_from(edges)
    
    return G


def create_network(N, j, k):
    G = nx.Graph()
    
    # Create N nodes
    nodes = range(N)
    G.add_nodes_from(nodes)
    
    for node in nodes:
        # Generate random number of edges for the node
        num_edges = random.randint(j, k)
        
        # Randomly select nodes to connect to
        other_nodes = list(nodes)
        other_nodes.remove(node)  # Remove current node from the list
        
        # Connect to the selected nodes
        selected_nodes = random.sample(other_nodes, num_edges)
        edges = [(node, selected_node) for selected_node in selected_nodes]
        G.add_edges_from(edges)
    
    return G


# Generate a random network with desired edge constraints
num_nodes = 200_000
min_edges = 1
max_edges = 10

fname = 'output/network.graphml'
if os.path.isfile(fname):
    print(f"restore network from {fname}")
    network = nx.read_graphml(fname)
else:
    os.makedirs("output", exist_ok=True)
    print(f"create network {num_nodes}")
    network = create_network(num_nodes, min_edges, max_edges)
    nx.write_graphml(network, fname)

print("create/load network done")
print("Size of network: {}".format(network.number_of_nodes()))

# Calculate memory usage
memory_usage = sys.getsizeof(network)

# Print the memory usage in bytes
print("Memory Usage:", memory_usage, "bytes")

# Calculate the degree centrality
print("centrality")
centrality = nx.degree_centrality(network)

# Get the top 10 nodes with highest degree centrality
top_10_nodes = sorted(centrality, key=centrality.get, reverse=True)[:10]

# Print the top 10 nodes with highest degree centrality
print("Top 10 nodes with highest degree centrality:")
for node in top_10_nodes:
    print("Node {}: Degree Centrality {}".format(node, centrality[node]))

if False:
    #matrix is too big, can we use sparse matrix ?

    # Calculate the Laplacian matrix
    laplacian = nx.laplacian_matrix(network).toarray()

    # Calculate the Laplacian eigenvalues and eigenvectors
    eigenvalues, eigenvectors = np.linalg.eigh(laplacian)

    # Print the Laplacian matrix and eigenvalues
    print("Laplacian Matrix:")
    print(laplacian)
    print("\nEigenvalues:")
    print(eigenvalues)

if True:
    G = network
    # Create a sparse adjacency matrix from the network
    adj_matrix = nx.adjacency_matrix(G)

    # Calculate the degree centrality
    degree_centrality = nx.degree_centrality(G)

    # Sort the nodes based on degree centrality in descending order
    sorted_nodes = sorted(degree_centrality, key=degree_centrality.get, reverse=True)

    # Print the top 5 nodes based on degree centrality
    print("Top 5 nodes based on degree centrality:")
    for node in sorted_nodes[:5]:
        print(f"Node {node}: {degree_centrality[node]}")
    

    # Calculate Laplacian matrix
    #laplacian_matrix = nx.laplacian_matrix(G)
    laplacian_matrix = nx.laplacian_matrix(G).astype(float)

    # Calculate eigenvalues of Laplacian matrix
    #num_eigvals = 5
    #num_eigvals = G.number_of_nodes()
    num_eigvals = 10
    eigenvals, _ = sla.eigsh(laplacian_matrix, k=num_eigvals)

    # Sort eigenvalues in ascending order
    sorted_indices = np.argsort(eigenvals)

    # Get the top 5 eigenvalues and their corresponding indices
    top_eigenvals = eigenvals[sorted_indices][:5]
    top_indices = sorted_indices[:5]

    # Print degree centrality, adjacency matrix, and top eigenvalues
    #print("Degree Centrality:", degree_centrality)
    #print("Adjacency Matrix:\n", adj_matrix.toarray())

    print("Top 5 Eigenvalues:", top_eigenvals)
    print("Top 5 Eigenvalue Indices:", top_indices)
    

