class Robot
  attr_reader :serial_number,
              :name,
              :city,
              :state,
              :avatar,
              :birthdate,
              :date_hired,
              :department

  def initialize(data)
    @serial_number = data[:serial_number]
    @name          = data[:name]
    @city          = data[:city]
    @state         = data[:state]
    @avatar        = data[:avatar]
    @birthdate     = data[:birthdate]
    @date_hired    = data[:date_hired]
    @department    = data[:department]
  end

end
