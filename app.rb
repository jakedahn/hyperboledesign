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
                :via => :smtp,
                :via_options => {
                  :address        => "smtp.sendgrid.net",
                  :port           => "25",
                  :authentication => :plain,
                  :user_name      => ENV['SENDGRID_USERNAME'],
                  :password       => ENV['SENDGRID_PASSWORD'],
                  :domain         => ENV['SENDGRID_DOMAIN']
                }
        )
                
        unless request.xhr?
          haml :contact
        else
          return {:success => true }.to_json
        end
      else
        @errors = email.errors
        
        @name = @errors["name"].blank? ? "" : "error"
        @email = @errors["email"].blank? ? "" : "error"
        @msg = @errors["msg"].blank? ? "" : "error"

        unless request.xhr?
          haml :contact
        else
          return  {:success => false, :errors => @errors}.to_json
        end
      end
    end
    
    get "*" do
      haml :fourohfour
    end

  end
end