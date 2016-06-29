require 'yaml/store'

class RobotDirectory
  attr_reader :directory

  def initialize(directory)
    @directory = directory
  end

  def create(robot)
    directory.transaction do
      directory['robots'] ||= []
      directory['total'] ||= 0
      directory['total'] += 1
      serial = directory['total'] * rand(100)
      directory['robots'] << { 'serial_number' => serial,
                               'name' => robot[:name],
                               'city' => robot[:city],
                               'state' => robot[:state],
                               'avatar' => "https://robohash.org/#{serial}",
                               'birthdate' => robot[:birthdate],
                               'date_hired' => robot[:date_hired],
                               'department' => robot[:department] }
    end
  end

  def all
    raw_robots.map { |robot| Robot.new(robot) }
  end

  def raw_robots
    directory.transaction do
      directory['robots'] || []
    end
  end

  def raw_robot(serial_number)
    raw_robots.find { |robot| robot['serial_number'] == serial_number }
  end

  def find(serial_number)
    Robot.new(raw_robot(serial_number))
  end

  def update(serial_number, robot)
    directory.transaction do
      target_robot = directory['robots'].find { |robot| robot['serial_number'] == serial_number }
      target_robot['name']       = robot[:name]
      target_robot['city']       = robot[:city]
      target_robot['state']      = robot[:state]
      target_robot['avatar']     = robot[:avatar]
      target_robot['birthdate']  = robot[:birthdate]
      target_robot['date_hired'] = robot[:date_hired]
      target_robot['department'] = robot[:department]
    end
  end

  def delete(serial_number)
    directory.transaction do
      directory['robots'].delete_if { |robot| robot['serial_number'] == serial_number }
      directory['total'] -= 1
    end
  end

  def average_age
    ages = all.map { |robot| Time.now.year - Time.new(robot.birthdate).year }
    ages.reduce(:+) / ages.count
  end

  def hired_by_year
    years = all.map { |robot| Time.new(robot.date_hired).year }.sort
    unique_years = Hash.new(0)
    years.each { |year| unique_years[year] += 1 }
    unique_years
  end

  def by_department
    departments = all.map { |robot| robot.department }.sort
    unique_departments = Hash.new(0)
    departments.each { |department| unique_departments[department] += 1 }
    unique_departments
  end

  def by_city
    cities = all.map { |robot| robot.city }.sort
    unique_cities = Hash.new(0)
    cities.each { |city| unique_cities[city] += 1 }
    unique_cities
  end

  def by_state
    states = all.map { |robot| robot.state }.sort
    unique_states = Hash.new(0)
    states.each { |state| unique_states[state] += 1 }
    unique_states
  end

  def delete_all
    directory.transaction do
      directory['robots'] = []
      directory['total'] = 0
    end
  end

end
