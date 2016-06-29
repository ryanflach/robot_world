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
      directory['robots'] << { 'serial_number' => directory['total'] * rand(100),
                               'name' => robot[:name],
                               'city' => robot[:city],
                               'state' => robot[:state],
                               'avatar' => robot[:avatar],
                               'birthdate' => robot[:birth_date],
                               'date_hired' => robot[:date_hired],
                               'department' => robot[:department] }
    end
  end

  def all
    directory.transaction do
      robots.map { |robot| Robot.new(robot) }
    end
  end

  def robots
    directory.transaction do
      database['robots'] || []
    end
  end

  def robot(serial_number)
    robots.find { |robot| robot['serial_number'] == serial_number }
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
    end
  end

end
