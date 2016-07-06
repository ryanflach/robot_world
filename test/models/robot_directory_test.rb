require_relative '../test_helper'

class RobotDirectoryTest < Minitest::Test
  include TestHelpers

  def test_it_can_create_and_store_a_robot
    robot = {:name => 'Ryan',
             :city => 'State College', :state => 'PA',
             :avatar => 'https://robohash.org/249',
             :birthdate => '05/31/1985', :date_hired => '05/09/2016',
             :department => 'Web Dev'}

    assert_equal 0, robot_directory.all.count

    robot_directory.create(robot)

    assert_equal 1, robot_directory.all.count

    found_robot = robot_directory.find(robot_directory.all.first.serial_number)

    assert_equal 'Ryan', found_robot.name
    assert_instance_of Robot, found_robot
  end

  def test_it_can_return_an_array_of_all_stored_robots
    assert_equal [], robot_directory.all

    robot_1 = {:name => 'Ryan',
               :city => 'State College', :state => 'PA',
               :avatar => 'https://robohash.org/249',
               :birthdate => '05/31/1985', :date_hired => '05/09/2016',
               :department => 'Web Dev'}
    robot_2 = {:name => 'Rando',
               :city => 'Berkeley', :state => 'CA',
               :avatar => 'https://robohash.org/549',
               :birthdate => '05/31/1985', :date_hired => '05/09/2012',
               :department => 'Challenges'}

    robot_directory.create(robot_1)
    robot_directory.create(robot_2)

    assert_equal 2, robot_directory.all.count
    assert_instance_of Robot, robot_directory.all.first
    assert_instance_of Robot, robot_directory.all.last
    assert_equal "Ryan", robot_directory.all.first.name
    assert_equal "Rando", robot_directory.all.last.name
  end

  def test_it_can_find_an_individual_robot_by_serial_number
    robot_1 = {:name => 'Ryan',
               :city => 'State College', :state => 'PA',
               :avatar => 'https://robohash.org/249',
               :birthdate => '05/31/1985', :date_hired => '05/09/2016',
               :department => 'Web Dev'}
    robot_2 = {:name => 'Rando',
               :city => 'Berkeley', :state => 'CA',
               :avatar => 'https://robohash.org/549',
               :birthdate => '05/31/1985', :date_hired => '05/09/2012',
               :department => 'Challenges'}

    robot_directory.create(robot_1)
    robot_directory.create(robot_2)

    assert_equal "Web Dev", robot_directory.find(robot_directory.all.first.serial_number).department
  end

  def test_it_can_update_properties_of_a_stored_robot
    robot = {:name => 'Ryan',
             :city => 'State College', :state => 'PA',
             :avatar => 'https://robohash.org/249',
             :birthdate => '05/31/1985', :date_hired => '05/09/2016',
             :department => 'Web Dev'}
    robot_update = {:name => 'Rando',
                    :city => 'Berkeley', :state => 'CA',
                    :avatar => 'https://robohash.org/549',
                    :birthdate => '05/31/1985', :date_hired => '05/09/2012',
                    :department => 'Challenges'}

    robot_directory.create(robot)

    assert_equal 1, robot_directory.all.count
    assert_equal "State College", robot_directory.all.first.city

    robot_directory.update(robot_directory.all.first.serial_number, robot_update)

    assert_equal 1, robot_directory.all.count
    assert_equal "Berkeley", robot_directory.all.first.city
  end

  def test_it_can_delete_a_stored_robot
    robot_1 = {:name => 'Ryan',
               :city => 'State College', :state => 'PA',
               :avatar => 'https://robohash.org/249',
               :birthdate => '05/31/1985', :date_hired => '05/09/2016',
               :department => 'Web Dev'}
    robot_2 = {:name => 'Rando',
               :city => 'Berkeley', :state => 'CA',
               :avatar => 'https://robohash.org/549',
               :birthdate => '05/31/1985', :date_hired => '05/09/2012',
               :department => 'Challenges'}

    robot_directory.create(robot_1)
    robot_directory.create(robot_2)

    assert_equal 2, robot_directory.all.count

    robot_directory.delete(robot_directory.all.first.serial_number)

    assert_equal 1, robot_directory.all.count
    assert_equal "Rando", robot_directory.all.first.name
  end
end
