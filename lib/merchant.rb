require "csv"
require "pry"

class Merchant 
  attr_reader :id

  attr_accessor :name

  def initialize(data)
     @id = data[:id].to_i
     @name = data[:name].to_s
    
  end

  def created_at
    #make hash here
  end

end