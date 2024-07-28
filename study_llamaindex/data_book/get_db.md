
get_db
[-help]
{[start [chain] [pattern1 [pattern2 ..] [[-if expression] | [-expr expression]] [-dbu] [-foreach tcl_body] [-index {object | obj_type1 name1 [object | obj_type2 name2 …]}] [-invert] [-regexp] [-match_hier] [-unique] [-computed]}
[-category category]
[-depth {[min] max}]
[-skip_fail]
Returns objects and attributes in the database with different types of filtering. The get_db commands takes a dual-ported object, dual-ported object list or a collection as input, then uses a period (.) to traverse to other related objects or to access attributes. You can use additional periods to traverse the data base schema.

Note: A Dual-Ported Object (DPO) is a Tcl_Obj in the C++ programming interface. The pointer is kept as a C++ pointer inside Tcl unless Tcl forces it to be evaluated as a string. In normal usage it never gets converted to a string which is more efficient, but if you do a "puts $var" or return the value to the shell, it will be converted to its "dual" string form.

The string form is normally a useful name preceded by the obj_type, so a base_cell object string form might look like base_cell:and2.

A netlist name will have the current design name included, so an instance named i1/i2 in design top, would look like inst:top/i1/i2.

An object with no name like a wire, will just show the pointer hex-value like wire:0x22222.

The get_db command accepts collections as an input but it only returns objects in dual-ported object list form.

For descriptions on all objects and attributes, see Common UI Database Object Information.

The root object has the current design data under the current_design attribute, while technology and library data are normally directly accessible as root attributes (e.g. layers and base_cells). The root object is the default starting point if there is no input list or collection given.

You can query a root attribute in any of the following ways:
get_db / .layers where, '/' is the notation for the root object get_db layers This implicitly starts at the root. In this usage, no "." is used before the "layers" attribute name.

For example, you can use the following command to get all the driver-pins of all nets in current_design:
>get_db current_design .nets.drivers Note: The current_design is implicitly created by the init_design or the read_db commands.

Frequently used current_design attributes like insts or hinsts (hierarchical insts) have root attribute aliases (or shortcuts). These attributes can be accessed by just typing the root attribute alias name.

For example, the following commands gets all instances of the current design with names that start with i1/i2*:
get_db current_design .insts i1/i2* get_db insts i1/i2* Where, insts is a root attribute alias for current_design .insts Some of the more commonly used aliases from the current_design attributes include: nets, pins, insts, hnets, hpins, and hinsts.

The get_db command supports auto-complete when you press the <Tab> key. It will give a list of all matching attributes starting with the letters entered so far, or it will complete the name if it is unique.

For example:
>get_db insts .par<Tab> parent partition
>get_db insts -if {.par<Tab>
parent partition If you press the <Shift+Tab> keys together, the matching attributes are displayed along with their help string, like this:
>get_db insts .par<Shift+Tab> parent \# The parent of the inst, which is either a hinst for an instance within hierarchy or the design object for an instance at the toplevel.

partition \# If this inst is a physical black_box, this partition will carry the pin constraints and related data for the blackbox. Otherwise it is empty. 

# Ui Text Database Access And Handling  And

There are two database definition objects: obj_type and attribute. If you want to query all the details for an attribute definition on an obj_type, rather than an attribute value, use the following command:
get_db attribute:<obj_type>/<attribute_name> .*
You can use get_db to query user-defined properties from LEF. Following is the mapping between the LEF objectType and database object:
LAYER -> layer LIBRARY -> design MACRO -> base_cell NONDEFAULTRULE -> route_rule PIN -> base_pin VIA -> via_def VIARULE -> via_def_rule Note: If PROPERTYDEFINITION is defined for LIBRARY, the PROPERTY will be mapped as a design attribute with a tech_lef_property_* prefix.

Copying and pasting pointers in an active session may cause the tool to crash. To prevent this situation, do not:
Copy pointers from the output of the get_db command and paste to another command as input.


Example:

The following command can be used to see all the root attributes associated with the category place:

get_db –category place

The output is as follows:

place_design_floorplan_mode place_design_refine_place place_detail_allow_border_pin_abut ...

You can view the complete list of categories with the get_db categories command as follows:

innovus 1> get_db categories active_logic_view add_endcaps add_fillers add_rings ...

Data_type: string, optional

chain Specifies the chain in the form [.attribute_name1 [.attribute_name2]...]. A chain always starts with a ".".

The specified attribute names are valid for each level of the traversal in the chain.

Example: The following command returns the names of pins of $my_insts

get_db $my_insts .pins.name

If the chain has a * or ? in the attribute name, it will be expanded to all matching attribute names, and the display will show the attribute name and current value for every object. This is intended for interactive usage, and no

values are returned to Tcl. Values that may require significant time to compute (like timing data that requires the timing-graph) will only be displayed if

For example:

get_db $my_insts .b*

Object: inst:top/i1

base_cell: base_cell:BUFX2 bbox: {34.32 10.08 38.94 15.12}

Object: inst:top/i2

...

Data_type: string, optional

   UI **Text**  

Database Access and Handling  and 

-computed Forces get_db to output the values of attributes that may require significant time to compute (like timing data that requires the timing-graph) when browsing many attributes at the same time. This is intended for interactive

usage when using a pattern match with * or ? for an attribute name. If only a single attribute name is given, then the value is always returned. Example:

>get_db $my_pins .slack_max* Object: pin:top/inst$odd/Y

slack_max: NC

slack_max_edge: NC ...

>get_db $my_pins .slack_max* -computed #if timing-graph not available yet, it will be computed

Object: pin:top/inst$odd/Y

slack_max: 550.12 slack_max_edge: rise

...

>get_db $my_pins .slack_max #single attribute names always return value and force computation if needed 550.12 ...

Data_type: bool, optional

-dbu Indicates that attribute values (coord, pt, rect, polygon, area, ...) should be returned as an int in database units.

The expression argument is a strict Tcl expression that can be passed as is to the Tcl expression command. It has a pre-defined Tcl array named with any attribute or chain value for each object as they are visited, and $obj(.) returns the object itself. For example, get_db insts -expr {$obj(.base_cell.name) eq "AND2"} #all insts that are AND2 char escaping, or complex $var substitution, you must use -expr. This parameter can be used with a chain and pattern like this: get_db $my_insts .pins i1/* -expr {$obj(.base_name) eq "A"} Here, the i1/* pattern is checked first for pin names that match i1/*, then the pin .base_name is checked if it is equals "A". -expr cannot be used at the same time with -if. Data_type: string, optional |

-depth {[min] max} Specifies the hierarchy depth range. It expands each design or hinst object in the input list into a list of design or hinst objects by descending the hinst hierarchy from

specified. 0 here signifies the level of the starting object.

The -depth expansion happens first, and the resulting expanded list is then processed as the input list of objects by get_db. For example:

get_db hinst:top/h1 -depth {0 1}

Returns hinst:top/h1, and the first level of hinsts below it.

Data_type: string, optional

-expr expression Returns the object if the expression is true. The expression argument is a strict Tcl expression that can be passed as is to the Tcl expression command. It has a pre-defined Tcl array named

with any attribute or chain value for each object as they are visited, and $obj(.) returns the object itself. For example,

get_db insts -expr {$obj(.base_cell.name) eq "AND2"} #all insts that are AND2

Normally the -if expression parameter is faster for simple expressions, but it is limited to a few operators, and simple $var substitution. If you need a full Tcl expression semantics including the proc calls inside [], special char escaping, or complex $var substitution, you must use -expr. This parameter can be used with a chain and pattern like this:

get_db $my_insts .pins i1/* -expr {$obj(.base_name) eq "A"}

Here, the i1/* pattern is checked first for pin names that match i1/*, then the pin .base_name is checked if it is equals "A".

-expr cannot be used at the same time with -if. Data_type: string, optional

# Ui Text Database Access And Handling  And

-foreach tcl_body Specifies a list of Tcl commands to process for each object. The return value is the number of objects that are processed and not the list of objects. This parameter avoids the overhead of creating long lists of objects. The Tcl

array $obj() is populated with the attributes of each object when it is visited, and $obj(.) is the object itself. The Tcl commands break and continue also work as expected in a more objects and get_db returns).

Unlike inside -if, the tcl_body is strict Tcl. The .attribute names are not substituted, you must use $obj() to access the attribute values instead. If you have a each object that matches the pattern, -if, or -expr expression.

For example, you can count all the insts as mentioned below:

set inst_count [get_db insts -foreach {}]

The following command prints the names of every inst that starts with "abc" and is an AND2 gate:

get_db insts abc* -if {.base_cell.name == AND2} -foreach {puts $obj(.name)}

It returns the total number of insts that are printed.

Data_type: string, optional

-if expression Specifies a boolean expression, with extensions to make pattern matching simpler.

== and != do not require a quoted string, and they support pattern matching with * and ?. Other operators like >, <, <=, >=, &&, ||, and the unary negate operator ! are supported. Parentheses "( )" can be used to group complex expressions.

Note: Unlike the <pattern> argument, inside the -if expression, you cannot use a string pattern to implicitly match the .name attribute of an object. You must use the .name field directly. For example, the following command

will not match anything because .base_cell will become something like base_cell:AND2.

>get_db insts -if {.base_cell == buf*} #matches nothing

use either of these instead:

>get_db insts -if {.base_cell.name == buf*} #match the .name attribute

>get_db insts -if {.base_cell == base_cell:buf*} #match the DPO name directly

Note: If you use an attribute that is an object list (like .pins), every object in the list is tested in an "implicit OR", so if any of them pass, the expression is matched.

Handling of indexed attributes inside of the -if statement:

The -index option is kept outside of the -if statement

The -index option MUST be valid for ALL attributes inside the -if statement otherwise an error occurs

Examples:

The following command finds all instances with base_cell names that matches "buf*".

get_db insts -if {.base_cell.name == buf*}

The following command returns all insts that have one or more pins that match CLK*. Only one copy of the matching inst object is returned, even if multiple pin names match CLK*.

get_db insts -if {.pins.base_name == CLK*}

The following command gets all pins where delay_max_rise is greater than 5 or slew_max_fall is smaller than 8. This is a valid command as both delay* and slew* are attributes indexed by abbreviation of analysis_view).

get_db pins -if {.delay_max_rise > 5 || .slew_max_fall < 8 } -index {view v1}

Note: The -if parameter does not support the usage of embedded Tcl command as operands. Use the -expr for this requirement.



<Up>The pattern matching can also work directly on a dual-ported object. In that case, it will match the '.name' attribute of the object, but return the object rather than the .name string. This matching works only for objects that

have a .name attribute defined. For example, the following command finds all instance objects (not names) with a name starting with A:

get_db insts A*

inst:top/A0 inst:top/A1/A2 …

The pattern matching can also work to match multiple lists of the name patterns. Refer to the following example:

get_db {*/BC* *TC*}

CG/BC1 CG/BC2 TC1 TC2 TC3 TC4 0x19f

Note: For the special case where a pattern string starts with '.' you need to use an extra '.' (an empty attribute name)

so that '.text' is treated as a pattern and not as an attribute name.

The following command finds all nets whose names equal to .odd_name

get_db nets . .odd_name

The following command finds all instance names starting with A or B:

get_db insts A* B*

Data_type: string, optional

-regexp Specifies that pattern use *regexp* syntax instead of the simple * and ? style. It does not change the -if pattern matching. See the example below to understand the usage of the

get_db insts -regexp {u_warmreset_cntr/reset_cntr_reg_(\d+)_}

Data_type: bool, optional

-skip_fail Skips displaying the fail error, when the object does not have the specified attribute.

Data_type: bool, optional

The following command returns a root attribute that is a simple value.

>get_db timing_cap_unit

If the name has a * or ?, it will be expanded to all matching root attribute names, and the display will show the attribute names and current value. This is intended for interactive usage, and no values are returned to Tcl. For

example,

>get_db timing* Object: root:/

timing_allow_input_delay_on_clock_source: false

timing_analysis_aocv: false

...

Data_type: tcl_obj, required

-unique Removes duplicate entries from the return list. If the specified attribute is a list, this parameter returns a unique set of lists., and does not uniquifies the elements within the list. In such a case, use

Data_type: bool, optional

## Built-In Sub-Attributes

The types rect, line, point, and polygon have built-in sub-attributes. For a full list of all built-in sub-attributes, see Common UI Database Object Information.

Example:
The rect type has built-in sub-attributes like:

| area      | Area of rect                 |
|-----------|------------------------------|
| dx        | Delta x                      |
| dy        | Delta y                      |
| ll        | Lower-left point             |
| ur        | Upper-right point            |
| width     | Shorter of dx and dy         |
| length    | Longer of dx and dy          |
| perimeter | Length of the rect perimeter |

A point has sub-attributes like:
x X coordinate y Y coordinate Like other attributes you can chain them together. For example, an inst object has a .bbox (bounding box) that is type "rect". Here are some operations allowed on the .bbox attribute of an inst.

get_db $my_inst .bbox
{1.0 2.0 3.0 4.0}
get_db $my_inst .bbox.ll {1.0 2.0}
get_db $my_inst .bbox.area 4.0 get_db $my_inst .bbox.ll.x 1.0 set box [get_db $my_inst .bbox] {1.0 2.0 3.0 4.0}
get_db $box .ll {1.0 2.0}

The following command finds insts with names starting with PTN* that have at least one pin capacitance > 0.1. The pattern is checked first, and those that pass will be tested with the -if expression. Inside the -if expression, there are many .pins for one inst, so each pin is tested. If any of the pins have a capacitance > 0.1, the single inst will be matched.

get_db insts PTN2* -if {.pins.capacitance_max_rise > 0.1}
The following command returns insts that are not physical-only cells whose name matches i1/i2*.

get_db insts i1/i2* -if {!.is_physical}
The two commands below generate the same list of pins from $my_insts that have a base_name clk. The first uses a * pattern to match all pins, while the second has no pattern and defaults to all pins, so both cases check the -if expression for all pins of $my_insts.

get_db $my_insts .pins * -if {.base_name == clk}
get_db $my_insts .pins -if {.base_name == clk}
The following command finds buf1 cell instances connected to nets named clk and changes their placement status to fixed.

Note: The examples below is inefficient and used to illustrate different methods of traversal done in different styles. A more efficient method would be to start from the nets and looking at their pin connections directly.

Example 1:
set cell_name buf1 set net_name clk foreach inst_obj [get_db insts] {
set cell_obj [get_db $inst_obj .base_cell] if { [get_db $cell_obj .name] == $cell_name } {
foreach pin_obj [get_db $inst_obj .pins] {
if { [get_db $pin_obj .net.name] == $net_name } {
set_db $inst_obj .place_status fixed
}
}
}
}
Example 2: Same output using full traversal style with intermediate variables. The second -if returns true if any of the .pins.net.name match $net_name (implicit OR).

set buf1_list [get_db insts -if {.base_cell.name == $cell_name}]
set buf1_clk1_list [get_db $buf1_list -if {.pins.net.name == $net_name}]
set_db $buf1_clk1_list .place_status fixed Example 3: Same output using full traversal style (fully chained)
set_db [get_db insts -if {.base_cell.name == $cell_name && .pins.net.name == $net_name}] .place_status fixed Example 4: Or use the -foreach method so no list is returned, but the number of buffers processed is returned.

get_db insts -if {.base_cell.name == $cell_name && .pins.net.name == $net_name} –foreach {set_db $obj(.) .place_status fixed}
The following command finds all the insts named i1/i2 that end with _buf:
get_db insts i1/i2/*_buf Or your could start inside the hinst named i1/i2:
get_db [get_db hinsts i1/i2] .insts *_buf Or use the hinst dual-ported object name directly. Note that netlist dual-ported object names have the design name included, so if top is the design name you could do this:
get_db hinst:top/i1/i2 .insts *_buf The following command gets arrival_max_rise for the analysis_view setup_test for all pins. Here the abbreviation "view" is allowed for analysis_view.

get_db pins .arrival_max_rise -index "view setup_test" The following command finds insts that have a cell_port named CK and that pin is connected to a net named clk*:
get_db insts -if {.lib_cells.lib_pins.name == */CK && .pins.net.name == clk*}
The following command uses -foreach to find the first inst named u1/* with .place_status "fixed" and then break. It uses strict Tcl inside the -foreach.

get_db insts u1/* -foreach { if {[string match fixed $obj(.place_status)]} { puts $obj(.name) ; break } }
The following get_db command uses -foreach to count the number of each base_cell used in the netlist inside the cell_count Tcl array. You can then use array get cell_count to see a list of all the base_cell names and how many times they are used in the netlist.

get_db insts .base_cell -foreach {incr cell_count($obj(.name))}
The following get_db command displays all the details of the flow_template_type attribute of the root obj_type:
get_db attribute:root/flow_template_type .*
Object: attribute:root/flow_template_type base_name: flow_template_type category: flow check_function: {} compute_function: {}
data_type: string default_value: {}
help: {Type of template being run.} indices: is_computed: false is_obsolete: false is_settable: true is_user_defined: true name: root/flow_template_type obj_type: obj_type:root 
