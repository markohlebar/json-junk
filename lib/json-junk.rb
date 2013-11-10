require "rubygems"
require "json"

#adds a suffix to a file path, i.e. file_path.sh = file_path-suffix.sh
def add_suffix(file_path, suffix) 
  File.basename(file_path, ".*") + suffix + File.extname(file_path)
end

def is_collection(collection) 
	collection.respond_to?'each'
end 

class JsonJunk 
	def initialize(json_file_path, export_suffix, junk) 
		@json_file_path = json_file_path
		@export_suffix = export_suffix
		@junk = junk
	end
	
	def junkify()
# 		puts @json_file_name
# 		puts @export_suffix
		export_file_path = add_suffix(@json_file_path, @export_suffix)
		parsed_object = JSON.parse(File.read(@json_file_path))
		
		if parsed_object.is_a?(Hash)
		    modified_hash = recurse_collection_and_junkify_leafs(parsed_object, @junk)
		    json_string = JSON.pretty_generate(modified_hash)
		    File.open(export_file_path, 'w').write(json_string)
		end 
	end 

	def recurse_collection_and_junkify_leafs(collection, junk)	
		modified_collection = collection.clone()
		#check if leaf is a collection
		if modified_collection.is_a?(Hash)
			modified_collection.each do |key, value|
				if is_collection(value)
					modified_collection[key] = recurse_collection_and_junkify_leafs(value, junk)
				else 
					modified_collection[key] = junk
				end	
			end	
		elsif modified_collection.is_a?(Array)
			array = Array.new()
			modified_collection.each do |value| 
				new_value = junk
				if is_collection(value) 
					new_value = recurse_collection_and_junkify_leafs(value, junk)
				end
				array.push(new_value)
			end	
			#store all modified values back to modified collection 		
			modified_collection = array.clone()
			else 
		end			
		modified_collection
	end  	  
end




