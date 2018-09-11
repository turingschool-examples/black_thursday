require_relative './sales_engine'

class SalesAnalyst
  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    item_count = @engine.items.all.size
    merch_count = @engine.merchants.all.size
    (item_count.to_f / merch_count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    counts = @engine.merchants.all.inject([]) do |accumulator, merch|
      accumulator << @engine.items.find_all_by_merchant_id(merch.id).length
    end
    std_dev(counts)
  end

end
