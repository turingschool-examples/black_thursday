require 'bigdecimal'
require 'time'

class Item

  attr_accessor :attributes

  def initialize(item_data)
    @attributes = {id:          item_data[:id],
                  name:         item_data[:name],
                  description:  item_data[:description],
                  unit_price:   item_data[:unit_price],
                  created_at:   item_data[:created_at],
                  updated_at:   item_data[:updated_at],
                  merchant_id:  item_data[:merchant_id]}
  end

  def id
    @attributes[:id]
  end

  def name
    @attributes[:name]
  end

  def description
    @attributes[:description]
  end

  def unit_price
    @attributes[:unit_price]
  end

  def created_at
    @attributes[:created_at]
  end

  def updated_at
    @attributes[:updated_at]
  end

  def merchant_id
    @attributes[:merchant_id]
  end

  def unit_price_in_dollars
    unit_price.to_f
  end

end
