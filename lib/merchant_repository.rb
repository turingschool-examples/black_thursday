require_relative 'merchant'
require          'csv'
require          'pry'

class MerchantRepository
attr_reader :merchant_instances

  def initialize(csv_hash)
    @merchant_instances ||= csv_hash.map do |csv_hash|
      merchant = Merchant.new(csv_hash)
    end
  end

  def all
    merchant_instances
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end


  def standard(data_to_be_standardized)
    data_to_be_standardized.to_s.downcase.gsub(" ", "")
  end

  def find_by_id(merchant_id)
    merchant_instances.find { |item| item.id == merchant_id.to_i}
  end

  def find_by_name(merchant_name)
    merchant_instances.find {|merchant| standard(merchant.name) == standard(merchant_name)}
  end

  def find_all_by_name(merchant_name)
    merchant_instances.find_all { |merchant| merchant.name.downcase.include? standard(merchant_name) }
  end

  def items_per_merchant
    all.map {|merchant| merchant.items.count}
  end

  def average_items_per_merchant
    (items_per_merchant.inject(0.0) {|sum, items| sum + items} / number_of_merchants).round(2)
  end

  def number_of_merchants
    all.count
  end

  def sum_deviations_from_the_mean
    items_per_merchant.inject(0) do |accum, items|
      accum + (items - average_items_per_merchant) ** 2
    end
  end

  def variance_items
    sum_deviations_from_the_mean / (number_of_merchants - 1)
  end

  def all_merchants_ids
    all.map(&:id)
  end

  def invoices_per_merchant
    all.map {|merchant| merchant.invoices.count}
  end

end
