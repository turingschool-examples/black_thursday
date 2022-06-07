require 'pry'

class Merchant
  attr_reader :id
  attr_accessor :name

  def initialize(data)
    @id = data[:id].to_i
    @name = data[:name]
  end
end
