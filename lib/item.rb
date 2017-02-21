require 'bigdecimal'
class Item
  attr_reader :values

  def initialize(values_hash)
    @values = values_hash
  end

  def id
    values[:id]
  end

  def name
    values[:name]
  end

  def description
    values[:description]
  end

  def unit_price
    values[:unit_price]
  end

  def created_at
    values[:created_at]
  end

  def updated_at
    values[:updated_at]
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

end
