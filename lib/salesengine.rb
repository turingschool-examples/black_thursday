require 'csv'
require './lib/merchantrepository'


class SalesEngine
  attr_reader :items, :merchants
  
  def initialize.from_csv(input)
    @items = input(:items)
    @merchants = input(:merchants)
  end


end