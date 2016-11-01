require 'pry'
require 'csv'

class Merchant
  attr_reader :merchants

  HASH = {:id => 0, :name => "name"}

  def initialize()
    @id = HASH[:id]
  end

  def id
    #returns integer ID of the merchant
  end

  def name
    #returns the name of the merchant
  end

end
