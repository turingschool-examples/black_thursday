require 'pry'

require_relative 'data_typing'


class Customer
  include DataTyping

  attr_reader :id,
              :created_at
              
  attr_accessor :first_name,
                :last_name,
                :updated_at

  def initialize(hash)
    @id         = make_integer(hash[:id])
    @first_name = hash[:first_name]
    @last_name  = hash[:last_name]
    @created_at = make_time(hash[:created_at])
    @updated_at = make_time(hash[:updated_at])
  end

end
