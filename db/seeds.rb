require 'sqlite3'

database = SQLite3::Database.new("db/robot_directory_development.db")

database.execute("DELETE FROM robots")

10.times do |n|
  database.execute("INSERT INTO robots
                    (name, city, state, avatar, birthdate, date_hired, department)
                    VALUES
                    ('Robot #{n + 1}', 'Example City', 'CO', 'https://robohash.org/#{n}',
                    '1995/#{n + 1}/#{n + 1}', '2016/#{n + 1}/#{n + 1}', 'Web Dev');")
  serial_number = database.execute("SELECT serial_number FROM robots WHERE name='Robot #{n + 1}';").flatten.first
  database.execute("UPDATE robots SET avatar='https://robohash.org/#{serial_number}' WHERE serial_number=#{serial_number}; ")
end

puts database.execute("SELECT * FROM robots;")
