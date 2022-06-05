class SalesAnalyst
  attr_reader :item_repository, :merchant_repository, :invoice_repository

  def initialize(item_repo, merchant_repo, invoice_repo)
    @item_repository = item_repo
    @merchant_repository = merchant_repo
    @invoice_repository = invoice_repo
  end

  def average_items_per_merchant
    (@item_repository.all.length.to_f / @merchant_repository.all.length).round(2)
    #round(2) rounds it to the second decimal place (2.88 vs 2.8842)
  end

  def average_items_per_merchant_standard_deviation
    merchant_ids
    items_count_list
    list = items_count_list # list = items_count_list.sample(5)
    mean = list.sum.to_f / list.size
    sum = list.sum {|num| (num - mean)**2}
    sd = (Math.sqrt(sum / (list.size - 1))).round(2)
  end

  def merchant_ids
    @merch_ids = @merchant_repository.all.map {|merchant| merchant.id}
  end

  def items_count_list
    items_list = @merch_ids.map {|id| @item_repository.find_all_by_merchant_id(id).count}
  end

  def merchants_with_high_item_count
    sd = average_items_per_merchant_standard_deviation
    high_sellers = merchant_ids.find_all do |id|
      @item_repository.find_all_by_merchant_id(id).count > (sd + average_items_per_merchant)
    end
    high_seller_merchants = high_sellers.map {|seller| @merchant_repository.find_by_id(seller)}
  end

  def average_item_price_for_merchant(merchant_id)
    items = @item_repository.find_all_by_merchant_id(merchant_id)
    prices = items.map {|item| item.unit_price_to_dollars}
    (prices.sum/items.count).round(2)
  end

  def average_average_price_per_merchant
    averages = merchant_ids.map {|merchant_id| average_item_price_for_merchant(merchant_id)}
    (averages.sum / averages.count).floor(2)
  end

  def golden_items
    prices = @item_repository.all.map {|item| item.unit_price_to_dollars}
    @item_repository.all.find_all {|item| item.unit_price_to_dollars > (prices.sum / prices.size + sd_prices * 2)}
  end

  def sd_prices
    prices = @item_repository.all.map {|item| item.unit_price_to_dollars}
    mean = prices.sum / prices.size
    sum = prices.sum {|num| (num - mean)**2}
    price_sd = (Math.sqrt(sum / (prices.size - 1))).round(2)
  end

  def average_invoices_per_merchant
    (@invoice_repository.all.length.to_f / @merchant_repository.all.length).round(2)
  end

end
