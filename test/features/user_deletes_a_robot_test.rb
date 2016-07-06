require_relative '../test_helper'

class UserDeletesARobotTest < FeatureTest
  def test_user_can_delete_a_robot
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

    visit '/'
    click_link("View All Robots")
    click_link("#{robot_directory.all.first.name}")
    click_button("Delete Robot")

    assert_equal "/robots", current_path
    assert page.has_content?("Rando")
    refute page.has_content?("Ryan")
  end
end
