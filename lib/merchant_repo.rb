require 'merchant'
require_relative 'findable'

class MerchantRepo
  include Findable
  attr_reader :merchants,
              :engine

  def initialize(path, engine)
    @merchants = []
    @engine = engine
    populate_information(path)
  end

  def populate_information(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |data|
      @merchants << Merchant.new(data, self)
    end
  end

  def all
    @merchants
  end

  def create(attributes)
    merchant = Merchant.new(attributes, self)
    max = @merchants.max_by do |merchant|
      merchant.id
    end
    merchant.update_id(max.id)
    @merchants << merchant
    merchant
  end

  def update(id, attributes)
    merchant = find_by_id(id, @merchants)
    return if !merchant
    merchant.update_name(attributes)
  end

  def delete(id)
    @merchants.delete(find_by_id(id, @merchants))
  end

  def item_count
    count = @engine.items.all.length
    count.to_f
  end

  def merchant_count
    count = all.length
    count.to_f
  end

  def average_items_per_merchant
    (item_count / merchant_count).round(2)
  end

  def item_count_per_merchant
    @engine.items.item_count_per_merchant
  end

  def average_items_per_merchant_standard_deviation
    average_items = average_items_per_merchant
    sum = item_count_per_merchant.sum do |merchant, count|
      (average_items - count)**2
    end
    sum = (sum / (merchant_count - 1))
    (sum ** 0.5).round(2)
  end

  def merchants_with_high_item_count
    one_deviation = average_items_per_merchant_standard_deviation + average_items_per_merchant
    high_merchants = []
    item_count_per_merchant.find_all do |id, count|
      high_merchants << find_by_id(id, @merchants) if count > one_deviation
    end
    high_merchants
  end

  def average_average_price_per_merchant
    all_items = item_count_per_merchant.length
    all_averages = all.sum do |merchant|
      @engine.average_item_price_for_merchant(merchant.id)
    end
    (all_averages / all_items.to_f).round(2)
  end
  
  def revenue_by_merchant_id
    merchants = Hash.new(0)
    @engine.invoices_by_merchant.each do |merchant, invoice|
      merchants[merchant] = invoice.sum do |invoice|
       invoice_total(invoice.id)
      end
    end
    merchants
  end
  
  def top_revenue_earners(range_end = 20)
    descending = revenue_by_merchant_id.sort_by do |merchant_id|
      merchant_id[1]
    end.reverse
    high_merchants = descending[0...range_end]
    high_merchants.map do |merchant|
      merchant.find_by_id(merchant[0])
    end
  end

  def merchants_ranked_by_revenue
    descending = revenue_by_merchant_id.sort_by do |merchant_id|
       merchant_id[1]
     end.reverse
    descending.map do |merchant|
      sales_engine.find_by_id(merchant[0])
    end
  end  
  
  def merchants_with_pending_invoices
    merchants = sales_engine.find_all_pending.map do |invoice|
      sales_engine.find_by_id(invoice.merchant_id, @merchants) if invoice_paid_in_full?(invoice.id) == false
    end
    merchants.compact.uniq
  end
  
  def merchants_with_only_one_item
    merchants = item_count_per_merchant.map do |merchant, count|
      @engine.find_by_id(merchant, @merchants) if count == 1
    end
    merchants.compact.uniq
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchants_with_only_one_item.find_all do |merchant|
      merchant.created_at.strftime("%B") == month
    end
  end

  def revenue_by_merchant(merchant_id)
    total = []
    revenue_by_merchant_id.each do |merchant, revenue|
      total << revenue if merchant == merchant_id
    end
    total[0]
  end
end
