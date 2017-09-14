require_relative 'sales_engine'

class SalesAnalyst

  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def total_item_count_per_merchant(merchant_repo)
    merchants = merchant_repo.merchants
    merchants.reduce(0) do |item_count, merchant|
      item_count + merchant.items.count
    end
  end

  def average_items_per_merchant
    #is this just items to merchants?
    #or is it only items specifically associated with merchants?
    #is it 0 or nil if merchant has no items?
    merchant_repo = @engine.merchants
    merchant_count = merchant_repo.merchants.count
    total_items = total_item_count_per_merchant(merchant_repo)
    total_items.to_f / merchant_count.to_f
  end

  def average_items_per_merchant_standard_deviation
    mean = average_items_per_merchant

    merchant_repo = @engine.merchants
    merchant_repo.reduce(0) do |result, merchant|
      difference_squared = (mean - merchant.items.count) ** 2
      result + difference_squared
    end

    sample_variance = result / (merchant_repo.merchants.count-1)
    Math.sqrt(sample_variance)

  end
end
