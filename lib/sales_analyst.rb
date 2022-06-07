require_relative 'entry'

class SalesAnalyst < SalesEngine
  attr_reader :item_repository,
              :merchant_repository,
              :invoice_repository,
              :invoice_item_repository,
              :transaction_repository,
              :customer_repository

  def average_items_per_merchant
    ((@item_repository.all.count.to_f / @merchant_repository.all.count.to_f).round(2))
  end
  #need to edit the SalesAnalyst parameters to get this to work. may also need to edit the tests too after.
  #need to add Transaction repo and invoice repo
  def invoice_paid_in_full?(invoice_id)
    x = @transaction_repository.all
    y = x.find do |transaction|
          invoice_id == transaction.invoice_id.to_i
        end
      if y.result == "success"
        return true
      else
        return false
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
  end
    #looking at spec harness, they want the sum for the test to be 21067.77.
    #Looking at the unit price in the invoice items csv,
    #there are no decimals. So I am confused.... :(
  end
  def average_item_price_for_merchant(merchant_id)
    x = @item_repository.all.find_all { |item| item.merchant_id == merchant_id }
    y = x.map do |item|
      item.unit_price
    end
      ((y.sum / x.count)/100).ceil(2)
  end

  def average_items_per_merchant_standard_deviation
    # x is a hash - merchant id's are assigned to keys and the values are arrays of their items
    merchant_ids = @item_repository.all.group_by {|item| item.merchant_id}
    merch_array = merchant_ids.flat_map {|_,value|value.count}
    merch_item_count = merch_array.map {|item_count|((item_count - average_items_per_merchant)**2)}
    Math.sqrt(((merch_item_count.sum) / (merch_item_count.count - 1)).to_f.round(2)).round(2)
  end

  def merchants_with_high_item_count
    std_dev = average_items_per_merchant_standard_deviation
    x = @item_repository.all.group_by {|item| item.merchant_id}
    merchant_id_array = x.keys.find_all do |id|
      @item_repository.find_all_by_merchant_id(id).count > (std_dev + average_items_per_merchant)
    end
    merchant_array = merchant_id_array.map {|merchant_id|@merchant_repository.find_by_id(merchant_id)}
  end

  def average_average_price_per_merchant
    counter = 0
    @merchant_repository.all.map do |merchant|
      counter += average_item_price_for_merchant(merchant.id)
    end
    (counter / @merchant_repository.all.count).floor(2)
  end

  def price_std_dev
    all_item_prices = @item_repository.all.map {|item| item.unit_price}
    all_items_count = @item_repository.all.count
    avg_item_price = (all_item_prices.sum/all_items_count)
    std_dev_difs = @item_repository.all.flat_map{|item|((item.unit_price - avg_item_price)**2)}
    sq_rt = Math.sqrt(((std_dev_difs.sum) / (all_items_count - 1)).to_f)
    std_dev_price = sq_rt.round(2)
  end

  def golden_items
    aappm = average_average_price_per_merchant
    psd = price_std_dev
    @item_repository.all.select do |item|
      item.unit_price > (aappm + (psd * 2))
    end
  end
end
