require 'csv'
class SalesEngine
  attr_reader:item_path,
             :merchant_path
  def initialize(locations)
  @item_path = locations[:items]
  @merchant_path = locations[:merchants]
  end

  def self.from_csv(locations)
    first_row = CSV.read("./data/merchants.csv") do |line|
      p line
    end
  end
end
