require "rubygems"
require "json"
require "ext/file_extensions"


#checks if the object is a collection
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
		export_file_path = File.add_suffix(@json_file_path, @export_suffix)
		parsed_object = JSON.parse(File.read(@json_file_path))
		
		if parsed_object.is_a?(Hash)
		    modified_hash = recurse_collection_and_junkify_leafs(parsed_object, @junk)
		    json_string = JSON.pretty_generate(modified_hash)
		    file = File.open(export_file_path, 'w')
		    file.write(json_string)
		    file.close()
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




