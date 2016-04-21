require 'csv'
require 'bigdecimal'
require 'time'
require 'date'

class Item
  attr_accessor :item_data
  attr_reader   :item_repo

  def initialize(item_data, item_repo)
    @item_data = item_data
    @item_repo = item_repo
  end

  def id
    @item_data[0].to_i
  end

  def name
    @item_data[1]
  end

  def description
    @item_data[2]
  end

  def unit_price
    BigDecimal.new(@item_data[3], 4) / BigDecimal.new(100)
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  def created_at
    Time.parse(@item_data[5])
  end

  def updated_at
    Time.parse(@item_data[6])
  end

  def merchant_id
    @item_data[4].to_i
  end

  def merchant
    engine = item_repo.sales_engine
    engine.merchants.find_by_id(merchant_id)
  end

end
