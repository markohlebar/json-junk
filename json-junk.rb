require "rubygems"
require "json"

json_file_path, options = ARGV


#adds a suffix to a file path, i.e. file_path.sh = file_path-suffix.sh
def add_suffix(file_path, suffix) 
  File.basename(file_path, ".*") + suffix + File.extname(file_path)
end

def is_collection(collection) 
	collection.respond_to?'each'
end 

$array_count = 0

def recurse_collection_and_nullify_leafs(collection)
# 	puts collection
	
	modified_collection = collection.clone()
	#check if leaf is a collection
	if modified_collection.is_a?(Hash)
		modified_collection.each do |key, value|
			if is_collection(value)
				modified_collection[key] = recurse_collection_and_nullify_leafs(value)
			else 
				modified_collection[key] = nil
			end	
		end	
	elsif modified_collection.is_a?(Array)
		$array_count += 1
		puts modified_collection
		puts "Start array #{$array_count}" 
		modified_collection.each do |value| 
			new_value = nil
			if is_collection(value) 
				new_value = recurse_collection_and_nullify_leafs(value)
			end
			puts "value = #{value}\n#########\nnewValue = #{new_value}\n$$$$$$$$$$$$"
			modified_collection.push(new_value)
			modified_collection.delete(value)
		end	
		puts "END"
	else 
#  		puts modified_collection
	end			
	modified_collection
end  	  

export_file_path = add_suffix(json_file_path, "-junk")
parsed_object = JSON.parse(File.read(json_file_path))

if parsed_object.is_a?(Hash)
    modified_hash = recurse_collection_and_nullify_leafs(parsed_object["metadata"]["results"][0])
#     modified_hash = recurse_collection_and_nullify_leafs(parsed_object)
    json_string = JSON.pretty_generate(modified_hash)
    File.open(export_file_path, 'w').write(json_string)
end 



