require 'yaml'
require 'pp'

class FBSFlow
	attr_accessor :name
	attr_accessor :config
	def initialize
	end

	def to_s
		map = {}
		map['@name'] = name
		"#<FBSFlow>"+map.to_s
	end
end

class FBSStep
	attr_accessor :path
	attr_accessor :flow
	def initialize
	end
end

class FBSConfig
	def initialize
		@step_by_path_map = {}
		@flow_by_name_map = {}
		@parameter_map = {}
	end
	def each_step &block
		@step_by_path_map.values.each &block
	end
	def init_with coder
		puts "YAML caller deserialize init_with(coder)"
		#pp coder
		initialize
		coder.map.each { |k,v|
			case k
			when 'SS_STEP'
				step_map = v
				step_map.each { |step_path, flow_name|
					flow = @parameter_map[flow_name]
					if not flow
						flow = FBSFlow.new
						flow.name = flow_name.freeze
						flow.config = self
						@parameter_map[flow.name] = flow
					end
					step = FBSStep.new
					step.path = step_path.freeze
					step.flow = flow
					@step_by_path_map[step.path] = step
				}
			when /^[A-Z][A-Z0-9_]+$/ #normal config parameter
				@parameter_map[k.to_sym] = v
			when /^([\w][\w\/]+)\.([A-Z][A-Z0-9_]+)$/ #config parameter for specific path
			else
				puts "[ERROR] can't handle key #{key}"
			end
				
		}
	end
end

def fbs_load_config file
	puts "[INFO] start to loading #{file}"
	YAML.add_tag "fbs_config", FBSConfig

	fbs = YAML.load_file file

	puts "[DEBUG] .....dump the fbs object"
	pp fbs
	puts "[DEBUG] ....."

	fbs
end