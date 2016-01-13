require 'pry'

class Merchant
  attr_accessor :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end

end
