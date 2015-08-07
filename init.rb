APP_ROOT = File.dirname(__FILE__)

$:.unshift( File.join(APP_ROOT, 'lib') )
require 'birthdays'

# App stores all data in a file called birthdays.txt
birthdays = Birthdays.new('birthdays.txt')
birthdays.launch!
