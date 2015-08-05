require 'birthday'

class Birthdays

	def initialize(path=nil)
		# locate the birthday text file at that path
		Birthday.filepath = path
		if Birthday.file_exists?
			puts "Found birthday file."
		# or create a new file
		elsif Birthday.create_file
			puts "Created birthday file."
		# exit if create fails
		else
			puts "Exiting.\n\n"
			exit!
		end
	end
	
	def launch!
		introduction
		# action loop
		#	what do you to do? (list, find, add, quit)
		# repeat until user quits
		# conclusion
	end
	
	def introduction
		puts "\n\n<<< Welcome to Verilogue's Birthday List >>>\n\n"
		puts "This is a listing of all Verilogue employee birthdays."
	end

end