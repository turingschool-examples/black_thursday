require 'pry'
require 'bigdecimal'
require_relative 'finder'


class Item
  include Finder

  attr_reader :id,
              :created_at,
              :merchant_id

  attr_accessor :name,
                :description,
                :unit_price,
                :updated_at

  def initialize(hash)
    # -- Read Only --
    @id = hash[:id]
    @created_at = hash[:created_at]
    @merchant_id = hash[:merchant_id]
    # -- Accessible --
    @name = hash[:name]
    @description = hash[:description]
    @unit_price = BigDecimal.new(hash[:unit_price], 4) #.to_f
    @updated_at = hash[:updated_at]
    # TO DO - How to handle -> New creations need Time.now for updated_at, created_at
  end

  def unit_price_to_dollars
    # TO DO - Is this supposed to be 2 decimal places?
    @unit_price.to_f
  end

end
