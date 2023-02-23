# Create a dictionary to represent the graph
set graph {}
dict set graph A {B C}
dict set graph B {D E}
dict set graph C {F G}
dict set graph D {}
dict set graph E {}
dict set graph F {}
dict set graph G {}

# Function to find leaf nodes
proc findLeafNodes {node graph} {
    # If the node is not in the graph, it is a leaf node
    puts "node $node"
    if {![dict exists $graph $node]} {
        return $node
    }
    set leafNodes {}
    # Recursively find leaf nodes for each child node
    foreach child [dict get $graph $node] {
        set childLeafNodes [findLeafNodes $child $graph]
        # Add the child's leaf nodes to the list
        foreach childLeafNode $childLeafNodes {
            lappend leafNodes $childLeafNode
        }
    }
    return $leafNodes
}

# Test the function on the graph
puts "Leaf nodes: [findLeafNodes A $graph]"
puts $graph
