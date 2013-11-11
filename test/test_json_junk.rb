require "minitest/autorun"
require "json_junk"
require "ext/file_extensions"
require "json"

class TestJsonJunk < MiniTest::Unit::TestCase
	def setup
		testdir = File.dirname(__FILE__)
		testdir = testdir+"/"
		
		@test_file = testdir + "test.json"
		@expected_file = testdir + "test-junk.json"
		
		suffix = "-temp"	
		jsonjunk = JsonJunk.new(@test_file, suffix, "junk")
		jsonjunk.junkify()
		
		@output_file = File.add_suffix(@test_file, suffix)
	end 
	
	def teardown
		File.delete(@output_file)
	end 
	
	def test_that_junk_file_is_created
		exists = File.exist?@output_file
		assert(exists, "Should create a file at #{@output_file}.");
	end
	
	def test_that_output_file_is_equal_expected_file
		junk_object = JSON.parse(File.read(@output_file))
		expected_object = JSON.parse(File.read(@expected_file))
		assert((junk_object.eql?expected_object), "Created object and expected object should be equal")
	end
end 