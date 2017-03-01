require './lib/helper'

class MerchantRepository

  attr_reader :all,
              :parent

  def initialize(merchant_data, parent)
    @all = merchant_data.map { |raw_merchant| Merchant.new(raw_merchant, self)}
    @parent = parent
  end

  def find_by_id(id)
    all.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    all.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(fragment)
    all.find_all do |merchant|
      merchant.name.downcase.include?(fragment.downcase)
    end
  end

  def find_items(id)
    parent.items.find_all_by_merchant_id(id)
  end

  def find_invoices(id)
    parent.invoices.find_all_by_merchant_id(id)
  end

  def invoices_per_merchant
    all.map do |merchant|
      merchant.invoices.length.to_f
    end
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end
end