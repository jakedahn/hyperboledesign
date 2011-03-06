require 'rubygems'
require 'sinatra'
require 'sass'
require 'haml'
require 'pony'

module SinatraApp
  class App < Sinatra::Base
    set :sessions, true
    set :public, File.dirname(__FILE__) + '/public'

    get '/' do
      haml :index
    end
    
    post '/contact' do
 
      Pony.mail(:to => "jake@hyperboledesign.com", 
                :from => params[:contact]["email"],
                :subject => "Contact Form Inquiry from #{params[:contact]['name']}",
                :body => erb(:email),
                :via_options => {
                  :address         => "smtp.sendgrid.net",
                  :port            => '25',
                  :user_name       => ENV['SENDGRID_USERNAME'],
                  :password        => ENV['SENDGRID_PASSWORD'],
                  :authentication  => :login,
                  :domain          => ENV['SENDGRID_DOMAIN']
                })
                
    end

  end
end