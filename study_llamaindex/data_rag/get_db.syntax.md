# Instruction #
Innovus TCL command syntax explain in a syntax 

in the deescription  [ arguments ] is optional argument of TCL command 

TCL arguments my have choice value  
-index {value1| value 2}  


# Context #

## Innovus tcl command syntax ###

get_db
[-help]
{[start [chain] [pattern1 [pattern2 ..] [[-if expression] | [-expr expression]] [-dbu] [-foreach tcl_body] [-index {object | obj_type1 name1 [object | obj_type2 name2 …]}] [-invert] [-regexp] [-match_hier] [-unique] [-computed]}
[-category category]
[-depth {[min] max}]
[-skip_fail]

#### Explain 2: can break down to server type of use ####

Syntax of use [start]:

get_db [insts|nets|ports| other starting objects] <name pattern> -if <expr> -foreach {runs per object in result collection} 


Code: 

```tcl
get_db insts abc* -if {.base_cell.name == AND2} -foreach {puts $obj(.name)}
```


## what is starting objects ##

The starting objects or root attributes. Can be an object list, collection, root (/), or root attribute. Example:
The following command returns the root attribute insts that is an object list of all insts in current_design.
>get_db insts
   The following command starts from a dual-ported object list or collection of objects in the Tcl variable $my_list, and returns a dual-port
>get_db $my_list
   The following command returns a root attribute that is a simple value.
>get_db timing_cap_unit
   If the name has a * or ?, it will be expanded to all matching root attribute names, and the display will show the attribute names and curre example,
>get_db timing*
  Object: root:/
  timing_allow_input_delay_on_clock_source: false
  timing_analysis_aocv: false

# Description # 

Innovus TCL command Description 


### example 1 ###

```tcl
get_db $my_insts .b*
```

results:

```output
 Object: inst:top/i1
    base_cell: base_cell:BUFX2 bbox: {34.32 10.08 38.94 15.12}

  Object: inst:top/i2
```

### TCL Example 2 ###
```tcl
get_db $my_pins .slack_max* Object: pin:top/inst$odd/Y
```

```output
Object: pin:top/inst$odd/Y

slack_max: 550.12 slack_max_edge: rise
```
