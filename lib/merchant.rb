require 'pry'
require 'csv'

class Merchant
  attr_reader :id,
              :name
  attr_accessor :items

  def initialize(hash)
    @id     = hash[:id]
    @name   = hash[:name]
    @items  = []
  end

end
