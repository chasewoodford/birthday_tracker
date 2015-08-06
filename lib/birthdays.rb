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
      puts "Found restaurant file."
      # or create a new file
    elsif Birthday.create_file
      puts "Created restaurant file."
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
      action = get_action
      result = do_action(action)
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
      action = user_response.downcase.strip
    end
    return action
  end

  def do_action(action)
    case action
    when 'list'
      puts "Listing..."
    when 'find'
      puts "Finding..."
    when 'add'
      add
    when 'quit'
      return :quit
    else
      puts "\nI don't understand that command.\n"
    end
  end

  def add
    puts "\nAdd a birthday\n\n".upcase
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
    puts "\n<<< Goodbye and Happy Birthday! >>>\n\n\n"
  end

end
