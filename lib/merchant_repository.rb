require_relative 'sales_engine'
require_relative 'merchant'
require_relative 'mathable'

class MerchantRepository
  include Mathable
  attr_reader :merchants, :engine

  def initialize(path, engine)
    @merchants = []
    @engine = engine
    make_merchants(path)
  end

  def inspect
   "#<#{self.class} #{@merchants.size} rows>"
  end

  def make_merchants(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      @merchants << Merchant.new(row, self)
    end
  end

  def all
    @merchants
  end

  def average_invoices_per_merchant
    average(invoices_per_merchant).round(2)
  end

  def bottom_merchants_by_invoice_count
    hash = invoices_per_merchant
    bottom_standard = average(hash) - (standard_deviation(hash) * 2)
    hash.each_with_object([]) do |(merchant_id, number_of_invoices), array|
      if number_of_invoices < bottom_standard
        array << find_by_id(merchant_id)
      end
    end
  end

  def best_item_for_merchant(merchant_id)
    find_by_id(merchant_id).best_item
  end

  def find_all_by_name(name)
    RepoBrain.find_all_by_partial_string(name, 'name', @merchants)
  end

  def find_by_id(id)
    RepoBrain.find_by_id(id, 'id', @merchants)
  end

  def find_by_name(name)
    RepoBrain.find_by_full_string(name, 'name', @merchants)
  end

  def find_item_by_id(item_id)
    @engine.find_item_by_id(item_id)
  end

  def create(attributes)
    attributes[:id] = RepoBrain.generate_new_id(@merchants)
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    @merchants << Merchant.new(attributes, self)
  end

  def delete(id)
    @merchants.delete(find_by_id(id))
  end

  def invoices_per_merchant
    @merchants.each_with_object({}) do |merchant, hash|
      hash[merchant.id] = merchant.invoices_count
    end
  end

  def merchant_invoices(merchant_id)
    @engine.merchant_invoices(merchant_id)
  end

  def merchant_invoice_items(invoice_id)
    @engine.invoice_items(invoice_id)
  end

  def merchant_items(merchant_id)
    @engine.merchant_items(merchant_id)
  end

  def merchant_invoices(merchant_id)
    @engine.merchant_invoices(merchant_id)
  end

  def merchants_created_in_month(month)
    @merchants.each_with_object([]) do |merchant, array|
      if merchant.created_at.strftime("%B") == month
        array << merchant
      end
    end
  end

  def merchant_sold_item_quantity_hash(merchant_id)
    @engine.merchant_sold_item_quantity_hash(merchant_id)
  end

  def merchant_sold_item_revenue_hash(merchant_id)
    @engine.merchant_sold_item_revenue_hash(merchant_id)
  end

  def merchant_successful_invoice_array(merchant_id)
    @engine.merchant_successful_invoice_array(merchant_id)
  end

  def merchants_with_only_one_item_registered_in_month(month)
    items_hash = @engine.items_created_in_month(month)
    merchants_month_hash = merchants_created_in_month(month)
    merchants_month_hash.find_all do |merchant|
      !items_hash[merchant.id].nil? && items_hash[merchant.id] == 1
    end
  end

  def most_sold_item(merchant_id)
    find_by_id(merchant_id).most_sold_item
  end

  def revenue_by_merchant(merchant_id)
    return nil if total_revenue_by_merchant.index(merchant_id).nil?
    index = total_revenue_by_merchant.index(merchant_id)
    return_value = total_revenue_by_merchant[index + 1]
  end

  def stdev_invoices_per_merchant
    standard_deviation(invoices_per_merchant).round(2)
  end

  def top_merchants_by_invoice_count
    hash = invoices_per_merchant
    top_standard = average(hash) + (standard_deviation(hash) * 2)
    hash.each_with_object([]) do |(merchant_id, number_of_invoices), array|
      if number_of_invoices > top_standard
        array << find_by_id(merchant_id)
      end
    end
  end

  def top_revenue_earners(num_earners)
    array = total_revenue_by_merchant.select{|x| x % 1 == 0}.first(num_earners)
    array.map do |merchant_id|
      find_by_id(merchant_id)
    end
  end

  def total_revenue_by_merchant
    @merchants.each_with_object(Hash.new(0)) do |merchant, hash|
      hash[merchant.id] += merchant.total_revenue
    end.sort_by {|k, v| -v}.flatten
  end

  def update(id, attributes)
    if !find_by_id(id).nil?
      customer_to_update = find_by_id(id)
      customer_to_update.update(attributes)
    end
  end
end
