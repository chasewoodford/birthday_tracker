class Birthday

	@@filepath = nil
	def self.filepath=(path=nil)
		@@filepath = File.join(APP_ROOT, path)
	end
	
	def self.file_exists?
	end
	
	def self.create_file
	end
	
	def self.saved_birthdays
	end

end