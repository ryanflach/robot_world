require_relative '../test_helper'

class RobotTest < Minitest::Test

  def test_it_initializes_with_a_hash_and_assigns_attributes_correctly
    robot_details = {'serial_number' => 249, 'name' => 'Ryan',
                     'city' => 'State College', 'state' => 'PA',
                     'avatar' => 'https://robohash.org/249',
                     'birthdate' => '05/31/1985', 'date_hired' => '05/09/2016',
                     'department' => 'Web Dev'}
    robot = Robot.new(robot_details)

    assert_equal 249, robot.serial_number
    assert_equal "Ryan", robot.name
    assert_equal "State College", robot.city
    assert_equal "PA", robot.state
    assert_equal "https://robohash.org/249", robot.avatar
    assert_equal "05/31/1985", robot.birthdate
    assert_equal "05/09/2016", robot.date_hired
    assert_equal "Web Dev", robot.department

    assert_instance_of Robot, robot
  end

end
