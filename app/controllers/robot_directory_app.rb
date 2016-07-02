require 'pony'

class RobotDirectoryApp < Sinatra::Base

  use Rack::Auth::Basic, "Authorized Robot Makers Only" do |username, password|
    username == 'admin' and password == 'admin'
  end

  get '/' do
    @robots = robot_directory.all
    unless @robots.empty?
      @avg_age = robot_directory.average_age
      @years = robot_directory.hired_by_year
      @departments = robot_directory.by_department
      @cities = robot_directory.by_city
      @states = robot_directory.by_state
    end
    haml :dashboard
  end

  get '/robots/new' do
    @fake_robot = robot_directory.faker_info
    erb :new
  end

  get '/robots' do
    @robots = robot_directory.all
    erb :index
  end

  post '/robots' do
    robot_directory.create(params[:robot])
    @robot = robot_directory.find(robot_directory.all.last.serial_number)
    unless params[:email].empty?
      Pony.mail({:to => params[:email],
                :subject => "A robot named #{@robot.name} has been created!",
                :body => "Thanks for building #{@robot.name}! Their unique serial number is #{@robot.serial_number}.",
                :via => :smtp,
                :via_options => {
                  :address              => 'smtp.gmail.com',
                  :port                 => '587',
                  :enable_starttls_auto => true,
                  :user_name            => 'robotworldsender@gmail.com',
                  :password             => 'p@ssword9!',
                  :authentication       => :plain,
                  :domain               => 'localhost.localdomain'
                }
      })
    end
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
