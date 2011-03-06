require 'rubygems'
require 'sinatra'
require 'active_model'
require 'sass'
require 'haml'
require 'pony'
require 'json'

load "./methods.rb"

module SinatraApp
  class App < Sinatra::Base
    set :sessions, true
    set :public, File.dirname(__FILE__) + '/public'

    get '/' do
      haml :index
    end
    
    post '/contact' do      
      email = Email.new( params[:contact]["name"], 
                         params[:contact]["email"],
                         params[:contact]["message"]
      )
      
      if email.valid?
        Pony.mail(:to => "jake@hyperboledesign.com", 
                :from => params[:contact]["email"],
                :subject => "Contact Form Inquiry from #{params[:contact]['name']}",
                :body => erb(:email),
                # :via => :smtp,
                :via_options => {
                  :address         => "smtp.sendgrid.com",
                  :port            => '25',
                  :user_name       => ENV['SENDGRID_USERNAME'],
                  :password        => ENV['SENDGRID_PASSWORD'],
                  :authentication  => :login,
                  :domain          => ENV['SENDGRID_DOMAIN']
                }
        )
        return {:success => true }.to_json
      else
        puts email.errors
        return {:success => false, :errors => email.errors}.to_json
      end
    
      
              
    end

  end
end