require 'pry'
require 'bigdecimal'
class Item
  attr_reader :information

  def initialize(information,parent)
    @information = information
    @parent = parent
  end

  def id
    information["id"].to_i
  end

  def name
    information["name"]
  end

  def description
    information["description"]
  end

  def unit_price
    info = information["unit_price"]
    price = BigDecimal.new(info)
  end

  def merchant_id
    information["merchant_id"].to_i
  end

  def created_at
    start = information["created_at"]
    list = start.split(/[- :]/)
    time = Time.utc(list[0].to_i, list[1].to_i, list[2].to_i, list[3].to_i, list[4].to_i, list[5].to_i)
  end

  def updated_at
    update = information["updated_at"]
    list = update.split(/[- :]/)
    time = Time.utc(list[0].to_i, list[1].to_i, list[2].to_i, list[3].to_i, list[4].to_i, list[5].to_i)
  end
end
