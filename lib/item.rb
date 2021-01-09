
require_relative './time_store_module'
require 'bigdecimal'

class Item
  include TimeStoreable

  attr_accessor :name,
                :description,
                :unit_price

  attr_reader :id,
              :repository,
              :created_at,
              :updated_at,
              :merchant_id,
              :repository

  def initialize(data, repository)
    @repository   = repository
    @id           = data[:id].to_i
    @name         = data[:name]
    @description  = data[:description]
    @unit_price   = BigDecimal.new(data[:unit_price],4)
    @unit_price   = BigDecimal.new(data[:unit_price].to_i)/100
    @created_at   = time_store(data[:created_at])
    @updated_at   = time_store(data[:updated_at])
    @merchant_id  = data[:merchant_id].to_i
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

end
