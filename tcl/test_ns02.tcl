# Create a namespace and some variables
namespace eval ns1 {
    variable var1 10
    variable var2 20
    variable var3 30
}

namespace eval ns2 {
    proc foo {} {
        import_ns_vars ::ns1
        puts "foo3::var1 = $var1"
        puts "foo3::var2 = $var2"
        puts "foo3::var3 = $var3"
        puts "try to modify ns1 var"
        set ::ns1::var1 99
        puts "looks no change ?"
        puts "foo3::var1 = $var1"
    }
}

# this can only create copy of variable in upper space
proc import_ns_vars {src_namespace} {
    foreach varName [info vars ${src_namespace}::*] {
        upvar 1 [namespace tail $varName] var
        set var [set $varName]
    }
}


# Call the function
puts "run foo"
ns2::foo
