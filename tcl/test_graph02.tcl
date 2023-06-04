# define the graph as a dictionary
set graph {
    "A" {"B" "C"}
    "B" {"D" "E"}
    "C" {"F" "G"}
    "D" {}
    "E" {}
    "F" {}
    "G" {}
}

# function to find leaf nodes
proc findLeafNodes {graph} {
    set nodes [dict keys $graph]
    set nonLeafNodes {}
    set leafNodes {}

    # find non-leaf nodes
    foreach node $nodes {
        set children [dict get $graph $node]
        if {$children ne {}} {
            lappend nonLeafNodes $node
        }
    }

    # find leaf nodes
    foreach node $nodes {
        if {![lsearch -exact $nonLeafNodes $node]} {
            lappend leafNodes $node
        }
    }

    return $leafNodes
}

# call the function and print the results
set leafNodes [findLeafNodes $graph]
puts "Leaf nodes: $leafNodes"
