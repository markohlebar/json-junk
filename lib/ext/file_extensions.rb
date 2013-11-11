class File
	#adds a suffix to a file path, i.e. file_path.sh = file_path-suffix.sh
	def self.add_suffix(file_path, suffix) 
	  File.dirname(file_path) + "/" + File.basename(file_path, ".*") + suffix + File.extname(file_path)
	end
end