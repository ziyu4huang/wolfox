require 'yard'

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
p = YARD.parse('flow_def.rb')


# prints:
#"lib/foo.rb is 1240 characters"
#"lib/foo_bar.rb is 248 characters"

