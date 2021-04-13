require 'CSV'

class SalesEngine
  attr_reader :item,
              :merchant
  def initialize(sales_info)
    @item = sales_info[:items]
    @merchant = sales_info[:merchants]
  end

  def self.from_csv(sales_info)
    items = sales_info[:items]
    merchants = sales_info[:merchants]
    CSV.foreach(items, headers: true, header_converters: :symbol) do |row|
      require "pry"; binding.pry

    end
  end
end
