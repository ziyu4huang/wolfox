set graph {
    "A" "B"
    "A" "B"
}

# Create dictionary to hold nodes and their neighbors
set nodes [dict create]
foreach edge $graph {
    lassign $edge node1 node2
    dict incr nodes $node1
    dict lappend nodes $node1 $node2
}

# Find leaf nodes
set leafNodes {}
foreach node [dict keys $nodes] {
    if {[dict get $nodes $node] eq ""} {
        lappend leafNodes $node
    }
}

# Print leaf nodes
puts "Leaf nodes: $leafNodes"
