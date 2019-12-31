require_relative '../config/environment'

ActiveRecord::Base.logger = nil

cli = CommandLineInterface.new

cli.run

