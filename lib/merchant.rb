require 'pry'


class Merchant
  attr_reader :id,m   
              :name
  def initialize(data)
    @id   = data[:id]
    @name = data[:name]
  end
end
