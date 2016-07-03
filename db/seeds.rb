require 'sqlite3'
require 'faker'

database = SQLite3::Database.new("db/robot_directory_development.db")

database.execute("DELETE FROM robots")

10.times do |n|
  database.execute("INSERT INTO robots (name, city, state, avatar, birthdate, date_hired, department)
                    VALUES ('#{Faker::Name.first_name}',
                            '#{Faker::Address.city}',
                            '#{Faker::Address.state_abbr}',
                            'https://robohash.org/#{Faker::Code.ean}',
                            '#{Faker::Date.between('1900-01-01', '2000-01-01')}',
                            '#{Faker::Date.between('2000-01-01', Date.today)}',
                            '#{Faker::Commerce.department}');"
                  )
  # serial_number = database.execute("SELECT serial_number FROM robots WHERE name='Robot #{n + 1}';").flatten.first
  # database.execute("UPDATE robots SET avatar='https://robohash.org/#{serial_number}' WHERE serial_number=#{serial_number}; ")
end

puts database.execute("SELECT * FROM robots;")
