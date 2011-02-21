require 'rubygems'
require 'sinatra'
require 'sass'
require 'haml'

module SinatraApp
  class App < Sinatra::Base
    set :sessions, true
    set :public, File.dirname(__FILE__) + '/public'

    get '/' do
      haml :index
    end

  end
end