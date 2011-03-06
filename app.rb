require 'rubygems'
require 'sinatra'
require 'sass'
require 'haml'
require 'pony'
require 'yaml'
module SinatraApp
  class App < Sinatra::Base
    set :sessions, true
    set :public, File.dirname(__FILE__) + '/public'

    get '/' do
      haml :index
    end
    
    post '/contact' do
#foo  
      Pony.mail(:to => params[:contact]["email"], 
                :from => "jake@hyperboledesign.com",
                :subject => "Contact Form Inquiry from #{params[:contact]['name']}",
                :body => erb(:email),
                :via => :smtp, :smtp => {
                  :host     => env["SG_SERVER"],
                  :port     => '25',
                  :user     => env["SG_USER"],
                  :password => env["SG_PASS"],
                  :auth     => :login,
                  :domain   => "hyperboledesign.com"
                })
    end

  end
end