require 'bigdecimal'
require 'time'

class Item # < ItemRepo

  attr_reader :name, :repository, :merchant_id, :id, :description, :unit_price,
              :created_at, :updated_at

  def initialize(data, repository)
    @name = data[:name]#.to_s
    @merchant_id = data[:merchant_id].to_i
    @id = data[:id].to_i
    @description = data[:description]#.to.s
    @unit_price = BigDecimal.new(data[:unit_price])/100
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
    @repository = repository
  end

  def merchant
    repository.merchant(@merchant_id)
  end

  def unit_price_to_dollars
    @unit_price / 100.00
  end

end
