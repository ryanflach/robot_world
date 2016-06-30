class RobotDirectoryApp < Sinatra::Base

  get '/' do
    @robots = robot_directory.all
    unless @robots.empty?
      @avg_age = robot_directory.average_age
      @years = robot_directory.hired_by_year
      @departments = robot_directory.by_department
      @cities = robot_directory.by_city
      @states = robot_directory.by_state
    end
    erb :dashboard
  end

  get '/robots/new' do
    erb :new
  end

  get '/robots' do
    @robots = robot_directory.all
    erb :index
  end

  post '/robots' do
    robot_directory.create(params[:robot])
    redirect '/robots'
  end

  get '/robots/:serial_number' do |serial|
    @robot = robot_directory.find(serial.to_i)
    erb :show
  end

  get '/robots/:serial_number/edit' do |serial|
    @robot = robot_directory.find(serial.to_i)
    erb :edit
  end

  put '/robots/:serial_number' do |serial|
    robot_directory.update(serial.to_i, params[:robot])
    redirect "/robots/#{serial}"
  end

  delete '/robots/:serial_number' do |serial|
    robot_directory.delete(serial.to_i)
    redirect '/robots'
  end

  def robot_directory
    if ENV['RACK_ENV'] == 'test'
      directory = SQLite3::Database.new("db/robot_directory_test.db")
    else
      directory = SQLite3::Database.new("db/robot_directory_development.db")
    end
    directory.results_as_hash = true
    @robot_directory ||= RobotDirectory.new(directory)
  end
end
