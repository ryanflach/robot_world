# Set up environment variable for test database
ENV['RACK_ENV'] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)

require 'minitest/autorun'
require 'minitest/pride'

module TestHelpers

  def teardown
    # Need to write this method
    robot_directory.delete_all
    super
  end

  def robot_directory
    database = YAML::Store.new('db/robot_directory_test')
    @database ||= RobotDirectory.new(database)
  end

end
