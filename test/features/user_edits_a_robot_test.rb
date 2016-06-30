require_relative '../test_helper'

class UserEditsARobotTest < FeatureTest
  def test_user_can_edit_a_robot
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
    click_link("Edit Robot")

    assert_equal "/robots/#{robot_directory.all.first.serial_number}/edit", current_path

    fill_in "robot[name]", with: "Emporer Mao"
    fill_in "robot[city]", with: "State College"
    fill_in "robot[state]", with: "PA"
    fill_in "robot[birthdate]", with: "05/31/1985"
    fill_in "robot[date_hired]", with: "04/21/2014"
    fill_in "robot[department]", with: "QID"
    click_button("Edit Robot")

    assert_equal "/robots/#{robot_directory.all.first.serial_number}", current_path
    assert page.has_content?("Emporer Mao")
    refute page.has_content?("Ryan")
  end
end
