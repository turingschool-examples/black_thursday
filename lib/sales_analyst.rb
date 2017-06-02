require_relative './sales_engine'

class SalesAnalyst

  attr_reader :se
  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    mr = se.merchants.all
    ir = se.items.all

    average = (ir.length.to_f)/(mr.length)
    average.round(2)
  end

  def average_items_per_merchant_standard_deviation
    merchant_items = {}

    mr = se.merchants.all
    # binding.pry
    mr.each_with_index do |merchant, idx|
      # binding.pry
      merchant_items[idx] = se.items_by_merchant_id(merchant.id)
    end
    puts merchant_items
  end
end

se = SalesEngine.from_csv({:items => './test/data/items_test.csv',
          :merchants => './test/data/merchants_test.csv'})
sa = SalesAnalyst.new(se)

sa.average_items_per_merchant_standard_deviation
