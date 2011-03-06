require 'rubygems'
require 'sinatra'
require 'sass'
require 'haml'
require 'pony'
require 'json'

module SinatraApp
  class App < Sinatra::Base
    set :sessions, true
    set :public, File.dirname(__FILE__) + '/public'

    get '/' do
      haml :index
    end
    
    post '/contact' do
 
      begin
        Pony.mail(:to => "jake@hyperboledesign.com", 
                :from => params[:contact]["email"],
                :subject => "Contact Form Inquiry from #{params[:contact]['name']}",
                :body => erb(:email),
                :via => :smtp,
                :via_options => {
                  :address         => "smtp.sendgrid.com",
                  :port            => '25',
                  :user_name       => ENV['SENDGRID_USERNAME'],
                  :password        => ENV['SENDGRID_PASSWORD'],
                  :authentication  => :login,
                  :domain          => ENV['SENDGRID_DOMAIN']
                }
        )
        
        return {:status => true}.to_json
      rescue
        return {:status => false}.to_json
      end
              
    end

  end
end