class Birthday

  @@filepath = nil
  def self.filepath=(path=nil)
    @@filepath = File.join(APP_ROOT, path)
  end

  attr_accessor :first_name, :last_name, :date
  def self.file_exists?
    if @@filepath && File.exists?(@@filepath)
      return true
    else
      return false
    end
  end

  def self.file_usable?
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

  def self.saved_restaurants
    # read the restaurant file
    # return instances of restaurant
  end

  def initialize(args={})
    @first_name = args[:first_name] || ""
    @last_name = args[:last_name]   || ""
    @date = args[:date]             || ""
  end

  def self.build_using_questions
    args = {}

    print "First Name: "
    args[:first_name] = gets.chomp.strip

    print "Last Name: "
    args[:last_name] = gets.chomp.strip

    print "Date (MM/DD): "
    args[:date] = gets.chomp.strip

    return self.new(args)
  end

  def save
    return false unless Birthday.file_usable?
    File.open(@@filepath, 'a') do |file|
      file.puts "#{[@first_name, @last_name, @date].join("\t")}\n"
    end
    return true
  end

end