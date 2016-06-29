require 'models/robot_directory'

class RobotDirectoryApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)
  set :method_override, true

  get '/' do
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
    directory = YAML::Store.new('db/robot_directory')
    @robot_directory ||= RobotDirectory.new(directory)
  end
end
