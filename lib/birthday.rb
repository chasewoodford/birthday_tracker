class Birthday

  @@filepath = nil
  def self.filepath=(path=nil)
    @@filepath = File.join(APP_ROOT, path)
  end

  # Create reader and writer methods for all variables
  attr_accessor :first_name, :last_name, :date

  def self.file_exists?
    if @@filepath && File.exists?(@@filepath)
      return true
    else
      return false
    end
  end

  def self.file_usable?
    # All the reasons the file could fail to open
    return false unless @@filepath
    return false unless File.exists?(@@filepath)
    return false unless File.readable?(@@filepath)
    return false unless File.writable?(@@filepath)
    return true
  end

  def self.create_file
    File.open(@@filepath, 'w') unless file_exists?
    return file_usable?
  end

  def self.saved_birthdays
    # Read birthdays.txt file
    birthdays = []
    # If the file is accessible...
    if file_usable?
      # Open as readable document...
      file = File.new(@@filepath, 'r')
      # And for each line...
      file.each_line do |line|
        # Append the data array...
        birthdays << Birthday.new.import_line(line.chomp)
      end
      # Then close the file...
      file.close
    end
    # And return birthdays.
    return birthdays
  end

  def initialize(args={})
    # Set values to input or leave blank
    @first_name = args[:first_name] || ""
    @last_name = args[:last_name]   || ""
    @date = args[:date]             || ""
  end

  def import_line(line)
    # Parse variables on tab strike
    line_array = line.split("\t")
    @first_name, @last_name, @date = line_array
    return self
  end

  def self.build_using_questions
    args = {}

    print "First Name: "
    args[:first_name] = gets.chomp.strip

    print "Last Name: "
    args[:last_name] = gets.chomp.strip

    print "Date (MM-DD): "
    args[:date] = gets.chomp.strip

    return self.new(args)
  end

  def save
    # If birthdays.txt is accessible...
    return false unless Birthday.file_usable?
    # Append each input
    File.open(@@filepath, 'a') do |file|
      file.puts "#{[@first_name, @last_name, @date].join("\t")}\n"
    end
    return true
  end
end