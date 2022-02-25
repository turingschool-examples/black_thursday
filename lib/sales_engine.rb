require 'csv'
require 'pry'

class SalesEngine
  attr_reader :items, :merchants

  def self.from_csv(argument)
    @merchants = []
    @merchants = CSV.read(argument[:merchants], headers: true, header_converters: :symbol)
    @items = []
    @items = CSV.read(argument[:items], headers: true, header_converters: :symbol)
    [@items, @merchants]
  end

end
