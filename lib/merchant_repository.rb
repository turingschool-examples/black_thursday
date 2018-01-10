require 'csv'
require_relative '../lib/merchant'

class MerchantRepository

  attr_reader :all,
              :parent

  def initialize(file_path, parent)
    contents = CSV.open(file_path, headers: true, header_converters: :symbol)
    @all = contents.map do |row|
      Merchant.new({:id         => row[:id],
                    :name       => row[:name],
                    :created_at => row[:created_at]}, self)
    end
    @parent = parent
  end

  def call_items_from_merchant_id(merchant_id)
    parent.get_items_from_merchant_id(merchant_id)
  end

  def call_invoices_from_merchant_id(merchant_id)
    parent.get_invoices_from_merchant_id(merchant_id)
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

  def find_all_by_name(name_fragment)
    all.select do |merchant|
      merchant.name.downcase.include?(name_fragment.downcase)
    end
  end

  def call_customers_from_merchant_id(merchant_id)
    parent.get_customers_from_merchant_id(merchant_id)
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end
end
