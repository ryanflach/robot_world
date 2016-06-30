require 'sqlite3'

environments = ['test', 'development']
environments.each do |env|
  database = SQLite3::Database.new("db/robot_directory_#{env}.db")
  database.execute("CREATE TABLE robots(
                    serial_number INTEGER PRIMARY KEY AUTOINCREMENT,
                    name VARCHAR(64),
                    city CHAR(64),
                    state CHAR(2),
                    avatar VARCHAR(64),
                    birthdate VARCHAR(10),
                    date_hired VARCHAR(10),
                    department VARCHAR(64)
                    );")
  puts "Created the database for #{env}."
end
