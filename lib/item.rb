require 'bigdecimal'
require 'time'

class Item
    attr_reader :id, :name, :description, :unit_price, :created_at, :updated_at, :merchant_id

  def initialize(row, parent=nil)
    @id = row[:id].to_i
    @name = row[:name]
    @description = row[:description]
    @unit_price = BigDecimal.new(row[:unit_price])
    @created_at = Time.parse(row[:created_at])
    @updated_at = Time.parse(row[:updated_at])
    @merchant_id = row[:merchant_id].to_i
    @parent = parent
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  # def created_at
  #   # returns a Time instance for the date the item was first created
  # end
  #
  # def updated_at
  #   # returns a Time instance for the date the item was last modified
  # end

  # def merchant_id
  #   # returns the integer merchant id of the item
  # end
end


# spec harness error:   3) Iteration 0 Item #description returns the description
#      Failure/Error: expect(item_one.description.length).to eq 2236
#
#        expected: 2236
#             got: 2436
#
#        (compared using ==)
#      # ./spec/iteration_0_spec.rb:210:in `block (3 levels) in <top (required)>'


# 4) Iteration 0 Item #unit_price returns the unit price
#    Failure/Error: expect(item_one.unit_price).to eq 12.00
#
#      expected: 12.0
#           got: 1200.0 (0.12e4)
#
#      (compared using ==)
#    # ./spec/iteration_0_spec.rb:216:in `block (3 levels) in <top (required)>'
