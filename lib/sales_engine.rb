require 'csv'

class SalesEngine
  attr_reader :items

  def initialize(data)
    @items = data[:items]
    @merchants = data[:merchants]
  end

  def item_data
    @items.each do |category|
      category
    end
  end
end
