require 'yard'

include YARD
YARD::Parser::SourceParser.after_parse_file do |parser|
	puts "#{parser.file} is #{parser.contents.size} characters"

	#puts parser.to_s
	#puts parser.root.to_s
end

class MyModuleHandler < YARD::Handlers::Ruby::Base
  handles :module

  def process
    puts "Handling a module named #{statement[0].source}"
  end
end

#YARD.parse('lib/**/*.rb')


class RegexHandler < Handlers::Ruby::Base
  handles %r{^if x ==}
end
ast = Parser::Ruby::RubyParser.parse("if x == 2 then true end").ast

puts ast

Registry.clear
YARD.parse('flow_def.rb')

puts "0000"
puts Registry.at('#test').to_s
puts "111111111111111111"
puts Registry.at('#QUEUE').docstring
puts "22222222222222"
puts Registry.at('Foo#test').docstring

puts "3"*10
puts Registry.at('Foo').attributes

puts "4"*10
puts Registry.at('Foo#mode').docstring

puts "5"*10
puts Registry.at('Foo#mode').source

puts "6"*10
puts Registry.at('#QUEUE').source

puts "7"*10
puts Registry.at('#QUEUE').signature

puts "8"*10
puts Registry.at('#QUEUE').files
puts "9"*10
puts Registry.at('#QUEUE').namespace
puts "A"*10
puts Registry.at('#QUEUE').tags

# prints:
#"lib/foo.rb is 1240 characters"
#"lib/foo_bar.rb is 248 characters"

