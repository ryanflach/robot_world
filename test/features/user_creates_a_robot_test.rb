require_relative '../test_helper'

class UserCreatesARobotTest < FeatureTest
  def test_user_can_create_a_robot
    visit '/'
    click_link("Create New Robot")

    assert_equal '/robots/new', current_path

    fill_in "robot[name]", with: "Ryan"
    fill_in "robot[city]", with: "State College"
    fill_in "robot[state]", with: "PA"
    fill_in "robot[birthdate]", with: "05/31/1985"
    fill_in "robot[date_hired]", with: "04/21/2014"
    fill_in "robot[department]", with: "QID"
    click_button("Create Robot")

    assert_equal '/robots', current_path
    assert page.has_content?("Ryan")
  end
end
