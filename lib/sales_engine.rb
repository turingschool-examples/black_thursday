require 'csv'
class SalesEngine
attr_reader :items, :merchants

  def initialize(arg1)
    @items = CSV.readlines(arg1[:items], headers: true, header_converters: :symbol)
    @merchants = CSV.readlines(arg1[:merchants], headers: true, header_converters: :symbol)
  end

  def self.from_csv(arg1)
    new(arg1)
  end

end
