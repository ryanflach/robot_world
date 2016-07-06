require 'faker'

class RobotDirectory
  attr_reader :directory

  def initialize(database)
    @directory = database
  end

  def create(robot)
    directory.execute("INSERT INTO robots
      (name, city, state, avatar, birthdate, date_hired, department)
      VALUES
      (?, ?, ?, ?, ?, ?, ?);", robot[:name], robot[:city], robot[:state],
      'robohash', robot[:birthdate], robot[:date_hired], robot[:department])

    serial = directory.execute("SELECT serial_number
                                      FROM robots
                                      WHERE name=?;", robot[:name]).flatten.last['serial_number']
    directory.execute("UPDATE robots
                      SET avatar='https://robohash.org/#{serial}'
                      WHERE name=?;", robot[:name])
  end

  def all
    raw_robots.map { |robot| Robot.new(robot) }
  end

  def raw_robots
    directory.execute("SELECT * FROM robots;")
  end

  def raw_robot(serial_number)
    directory.execute("SELECT * FROM robots
                       WHERE serial_number=?;", serial_number).first
  end

  def find(serial_number)
    Robot.new(raw_robot(serial_number))
  end

  def update(serial_number, robot)
    directory.execute("UPDATE robots
                       SET name=?, city=?, state=?, birthdate=?, date_hired=?,
                       department=? WHERE serial_number=?;", robot[:name],
                       robot[:city], robot[:state], robot[:birthdate],
                       robot[:date_hired], robot[:department], serial_number)
  end

  def delete(serial_number)
    directory.execute("DELETE FROM robots WHERE serial_number=?;", serial_number)
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
    directory.execute("DELETE FROM robots;")
  end

  def faker_info
    {:name       => Faker::Name.first_name,
     :city       => Faker::Address.city,
     :state      => Faker::Address.state_abbr,
     :birthdate  => Faker::Date.between('1900-01-01', '2000-01-01'),
     :date_hired => Faker::Date.between('2000-01-01', Date.today),
     :department => Faker::Commerce.department
    }
  end

end
