require 'birthday'
class Birthdays

  class Config
    @@actions = ['list', 'find', 'add', 'quit']
    def self.actions; @@actions; end
  end

  def initialize(path=nil)
    # locate the birthdays text file at path
    Birthday.filepath = path
    if Birthday.file_usable?
      puts "Found birthdays file."
      # or create a new file
    elsif Birthday.create_file
      puts "Created birthdays file."
      # exit if create fails
    else
      puts "Exiting.\n\n"
      exit!
    end
  end

  def launch!
    introduction
    # action loop
    result = nil
    until result == :quit
      action, args = get_action
      result = do_action(action, args)
    end
    conclusion
  end

  def get_action
    action = nil
    # Keep asking for user input until we get a valid action
    until Birthdays::Config.actions.include?(action)
      puts "Actions: " + Birthdays::Config.actions.join(", ") if action
      print "> "
      user_response = gets.chomp
      args = user_response.downcase.strip.split(' ')
      action = args.shift
    end
    return action, args
  end

  def do_action(action, args=[])
    case action
    when 'list'
      list
    when 'find'
      keyword = args.shift
      find(keyword)
    when 'add'
      add
    when 'quit'
      return :quit
    else
      puts "\nI don't understand that command.\n"
    end
  end

  def list
    output_action_header("Listing birthdays")
    birthdays = Birthday.saved_birthdays
    output_birthday_table(birthdays)
  end

  def find(keyword="")
    output_action_header("Find a birthday")
    if keyword
      birthdays = Birthday.saved_birthdays
      found = birthdays.select do |bday|
        bday.first_name.downcase.include?(keyword.downcase) ||
        bday.last_name.downcase.include?(keyword.downcase) ||
        bday.date.include?(keyword)
      end
      output_birthday_table(found)
    else
      puts "Find using a key phrase to search the birthday list."
      puts "Examples: 'find Chase', 'find Woodford', 'find 10-26'\n\n"
    end
  end

  def add
    output_action_header("Add a birthday")
    birthday = Birthday.build_using_questions
    if birthday.save
      puts "\nBirthday added\n\n"
    else
      puts "\nSave error: birthday not added\n\n"
    end
  end

  def introduction
    puts "\n\n<<< Welcome to the Birthday Tracker >>>\n\n"
    puts "This is an interactive guide to help you find the birthday you're looking for.\n\n"
  end

  def conclusion
    puts "\n<<< Goodbye and Happy Birthday! >>>\n"
  end

  private

  def output_action_header(text)
    puts "\n#{text.upcase.center(60)}\n\n"
  end

  def output_birthday_table(birthdays=[])
    print " " + "First Name".ljust(25)
    print " " + "Last Name".ljust(25)
    print " " + "Date".rjust(6) + "\n"
    puts "-" * 60
    birthdays.each do |bday|
      line = " " << bday.first_name.ljust(25)
      line << " " + bday.last_name.ljust(25)
      line << " " + bday.date.rjust(6)
      puts line
    end
    puts "No listings found" if birthdays.empty?
    puts "-" * 60
  end

end
