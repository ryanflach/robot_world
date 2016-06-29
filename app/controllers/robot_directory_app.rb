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

  def robot_directory
    directory = YAML::Store.new('db/robot_directory')
    @robot_directory ||= RobotDirectory.new(directory)
  end
end
