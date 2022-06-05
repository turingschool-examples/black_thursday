require 'entry'
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

  end

end
