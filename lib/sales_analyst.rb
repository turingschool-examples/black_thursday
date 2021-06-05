require_relative 'helper_methods'

class SalesAnalyst
  include HelperMethods
  attr_reader :items, :merchants, :engine

  def initialize(item_repo, merchant_repo, engine)
    @items = item_repo
    @merchants = merchant_repo
    @engine = engine
  end

  def average_items_per_merchant
    # look at ItemRepo
    # groupBy MerchantId OR use find_all_by_merchant_id
    # a bunch of arrays by merchant
    # average of all of the array lengths = final average
  end

  def average_items_per_merchant_standard_deviation
    # stuff
  end

  def merchants_with_high_item_count
    # stuff
  end

  def average_item_price_for_merchant(merchant_id)
    # stuff
  end

  def average_average_price_per_merchant
    # stuff
  end

  def golden_items
    # stuff
  end

  def average_invoices_per_merchant
    # stuff
  end

  def average_invoices_per_merchant_standard_deviation
    # stuff
  end

  def top_merchants_by_invoice_count
    # stuff
  end

  def bottom_merchants_by_invoice_count
    # stuff
  end

  def top_days_by_invoice_count
    # stuff
  end

  def invoice_status
    # stuff
  end

end
