require_relative 'sales_engine'
require_relative 'invoice_analyst'
require_relative 'item_count_analyst'
require_relative 'item_price_analyst'
require_relative 'invoice_top_days'

class SalesAnalyst
  include InvoiceAnalyst
  include ItemCountAnalyst
  include ItemPriceAnalyst
  include InvoiceTopDays

  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def find_sample_variance(list, sum)
    sum / (list.count-1)
  end

  def standard_deviation(sample_variance)
    std_dev = Math.sqrt(sample_variance)
    std_dev.round(2)
  end

  def standard_deviation_above(mean, standard_deviation, dev_count = 1)
    mean + (standard_deviation * dev_count)
  end

  # def inspect
  #   "#<#{self.class} #{@items.size} rows>"
  # end

end
