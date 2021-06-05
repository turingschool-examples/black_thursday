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
    # do stuff
  end

  def merchants_with_high_item_count
    # do stuff
  end

  def average_item_price_for_merchant(merchant_id)
    # do stuff
  end

  def average_average_price_per_merchant
    # do stuff
  end

  def golden_items
    # do stuff
  end

  def average_invoices_per_merchant
    # do stuff
  end

  def average_invoices_per_merchant_standard_deviation
    # do stuff
  end

  def top_merchants_by_invoice_count
    # do stuff
  end

  def bottom_merchants_by_invoice_count
    # do stuff
  end

  def top_days_by_invoice_count
    # do stuff
  end

  def invoice_status
    # do stuff
  end

end
