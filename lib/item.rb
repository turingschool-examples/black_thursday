require 'time'
require 'bigdecimal'


class Item

  def initialize(item = {})
    @id = item.fetch(:id)
    @name = item.fetch(:name)
    @description = item.fetch(:description)
    @unit_price = item.fetch(:unit_price)
    @created_at = item.fetch(:created_at)
    @updated_at = item.fetch(:updated_at)
    @merchant_id = item.fetch(:merchant_id)
  end

  def id
    @id.to_i
  end

  def name
    @name
  end

  def description
    @description
  end

  def unit_price
    BigDecimal.new(@unit_price)
  end

  def created_at
    Time.parse(@created_at)
  end

  def updated_at
    Time.parse(@updated_at)
  end

  def merchant_id
    @merchant_id.to_i
  end

  def unit_to_dollar
    price = @unit_price.to_f.to_s
    "$#{price}"
  end

end
