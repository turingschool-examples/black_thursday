require 'pry'

require_relative 'data_typing'

class Merchant
  include DataTyping

  attr_reader   :id
  attr_accessor :name

  def initialize(hash)
    @id   = make_integer(hash[:id])
    @name = hash[:name]
  end

end
