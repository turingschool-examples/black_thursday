# frozen_string_literal: true

require 'bigdecimal'

# This object stores all of the data that is connected to the items, along with
# a reference to the parent, which is the item repository. All of these
# variables are stored as instance variables so they can be read outside of
# the class.
class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at
  def initialize(items, parent)
    @id                     = items[:id].to_i
    @name                   = items[:name]
    @description            = items[:description]
    @unit_price             = BigDecimal(items[:unit_price]) / 100
    @merchant_id            = items[:merchant_id]
    @created_at             = Time.now
    @updated_at             = Time.now
    @unit_price_to_dollars  = unit_price.to_f
    @parent                 = parent
  end
end
