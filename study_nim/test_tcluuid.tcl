set lib [pwd]/libtcluuid.so
puts "loading $lib"
load $lib

puts [uuid]
