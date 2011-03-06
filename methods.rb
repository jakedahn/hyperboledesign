
class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || "is not an email") unless
      value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  end
end

class Email
  include ActiveModel::Validations
  attr_accessor :name, :email, :msg
  
  def initialize(name, email, msg)
    self.name = name
    self.email = email
    self.msg = msg
  end
  
  validates_presence_of :name
  validates_presence_of :msg
  validates_presence_of :email
    
  validates :email, :email => true
end
