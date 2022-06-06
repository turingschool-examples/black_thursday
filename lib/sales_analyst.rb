class SalesAnalyst
  attr_accessor :item_repository, :merchant_repository

  def initialize(item_repository, merchant_repository)
    @item_repository = item_repository
    @merchant_repository = merchant_repository
  end

  def average_items_per_merchant
    (@item_repository.all.count.to_f / @merchant_repository.all.count.to_f).round(2)
  end

  #need to edit the SalesAnalyst parameters to get this to work. may also need to edit the tests too after.
  #need to add Transaction repo and invoice repo
  def invoice_paid_in_full?(invoice_id)
    x = @transactions_repository.all
    y = x.find do |transaction|
          transaction.invoice_id == invoice_id
      if y.result == "success"
        true
      end
    end
  end

  def invoice_total(invoice_id)
    x = @invoice_item_repository.all
    y = x.find_all do |invoice_item|
          invoice_item.invoice_id == invoice_id
        end
    #y should now be an array of invoice item instances
    z = y.find_all do |invoice_instance|
      invoice_instance.unit_price
    end
    #z should have an array of all unit prices from the same invoice id
    z.sum
    #looking at spec harness, they want the sum for the test to be 21067.77.
    #Looking at the unit price in the invoice items csv,
    #there are no decimals. So I am confused.... :(

  def average_item_price_for_merchant(merchant_id)
    x = @item_repository.all.find_all { |item| item.merchant_id == merchant_id }
    y = x.map do |item|
      item.unit_price
    end
      (y.sum / x.count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    # x is a hash - merchant id's are assigned to keys and the values are arrays of their items
    x = @item_repository.all.group_by {|item| item.merchant_id}
    y = x.flat_map {|_,value|value.count}
    z = y.map {|item_count|((item_count - average_items_per_merchant)**2)}
    Math.sqrt(((z.sum) / (z.count - 1)).to_f.round(2)).round(2)
  end

  def merchants_with_high_item_count
    std_dev = average_items_per_merchant_standard_deviation
    x = @item_repository.all.group_by {|item| item.merchant_id}
    merchant_id_array = x.keys.find_all do |id|
      @item_repository.find_all_by_merchant_id(id).count > (std_dev + average_items_per_merchant)
    end
    merchant_array = merchant_id_array.map {|merchant_id|@merchant_repository.find_by_id(merchant_id)}
  end

end
