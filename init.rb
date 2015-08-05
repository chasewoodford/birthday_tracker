APP_ROOT = File.dirname(__FILE__)

$:.unshift(File.join(APP_ROOT, 'lib'))
require 'birthdays' 

birthdays = Birthdays.new('birthdays.txt')
birthdays.launch!