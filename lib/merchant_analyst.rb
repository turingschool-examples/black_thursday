require_relative 'helper'

module MerchantAnalyst

    def invoices_per_merchant
      merchant_repository.invoices_per_merchant
    end

    def count_items_per_merchant
      all_merchants.map do |merchant|
        merchant.items.length.to_f
      end
    end

    def average_items_per_merchant
      average(count_items_per_merchant)
    end

    def average_items_per_merchant_standard_deviation
      standard_deviation(count_items_per_merchant)
    end

    def merchants_with_high_item_count
      one_sd = one_standard_deviation_above_mean(count_items_per_merchant)
      all_merchants.find_all do |merchant|
          merchant.items.length > one_sd
        end
    end

    def merchant_item_prices(id)
      find_merchant_items(id).map do |item|
        item.unit_price
      end
    end

    def average_item_price_for_merchant(id)
      average(merchant_item_prices(id))
    end

    def average_merchant_prices
      all_merchants.map do |merchant|
        id = merchant.id
        average_item_price_for_merchant(id)
      end
    end

    def average_average_price_per_merchant
      average(average_merchant_prices)
    end

    def paid_invoices_by_merchant(merchant)
      merchant.invoices.find_all {|invoice| invoice.is_paid_in_full? }
    end

    def revenue_by_invoices(invoices)
      invoices.reduce(0) do |sum, invoice|
        sum += invoice.total
      end
    end

    def merchant_revenue(merchant)
      invoices = paid_invoices_by_merchant(merchant)
      revenue_by_invoices(invoices)
    end

    def merchants_ranked_by_revenue
      all_merchants.sort_by do |merchant|
        merchant_revenue(merchant)
      end.reverse
    end

    def top_revenue_earners(x = 20)
      merchants_ranked_by_revenue.shift(x)
    end

    def revenue_by_merchant(merchant_id)
      merchant = merchant_repository.find_by_id(merchant_id)
      merchant_revenue(merchant)
    end

    def check_for_pending_invoices
      all_invoices.find_all { |invoice| !invoice.is_paid_in_full?}
    end

    def merchants_with_pending_invoices
      check_for_pending_invoices.map do |invoice|
        invoice.merchant
      end.uniq.compact
    end

    def merchants_with_only_one_item
      all_merchants.find_all do |merchant|
        merchant.items.length == 1
      end
    end

    def merchants_with_only_one_item_registered_in_month(month)
      merchants_with_only_one_item.find_all do |merchant|
        merchant.month_created.downcase == month.downcase
      end
    end

    def invoice_items_by_merchant(merchant)
      paid_invoices_by_merchant(merchant).map do |invoice|
        invoice.invoice_items
      end.flatten
    end

    def invoice_items_by_merchant_id(merchant_id)
      merchant = merchant_repository.find_by_id(merchant_id)
      invoice_items = invoice_items_by_merchant(merchant)
    end


    def return_top_items(item_ids)
      item_repository.all.find_all do |item|
        item_ids.include?(item.id)
      end
    end

    def most_sold_items(sold_count)
      max_value = sold_count.values.max
      item_ids = sold_count.keys.find_all do |item_id|
        sold_count[item_id] == max_value
      end
      return_top_items(item_ids)
    end

    def most_sold_item_for_merchant(merchant_id)
      invoice_items = invoice_items_by_merchant_id(merchant_id)
      sold_count = Hash.new(0)
      invoice_items.each do |invoice_item|
        sold_count[invoice_item.item_id] += invoice_item.quantity
      end
      most_sold_items(sold_count)
    end

    def best_item_for_merchant(merchant_id)
      invoice_items = invoice_items_by_merchant_id(merchant_id)
      item_id = invoice_items.max_by do |invoice_item|
        invoice_item.unit_price * invoice_item.quantity
      end.item_id
      item_repository.find_by_id(item_id)
    end
end