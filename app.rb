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
#foo  
      Pony.mail(:to => params[:contact]["email"], 
                :from => "jake@hyperboledesign.com",
                :subject => "Contact Form Inquiry from #{params[:contact]['name']}",
                :body => erb(:email),
                :via => :smtp, :smtp => {
                  :host     => "smtp.sendgrid.net",
                  :port     => '25',
                  :user     => ENV['SENDGRID_USERNAME'],
                  :password => NV['SENDGRID_PASSWORD'],
                  :auth     => :login,
                  :domain   => ENV['SENDGRID_DOMAIN']
                })
    end

  end
end