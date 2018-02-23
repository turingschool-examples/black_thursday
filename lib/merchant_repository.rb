require 'CSV'
require 'pry'
require_relative '../lib/merchant'

# Merchant Repository class
class MerchantRepository
  attr_reader :parent
  def initialize(filepath, parent)
    @merchants = []
    @parent = parent
    load_merchants(filepath)
  end

  def all
    @merchants
  end

  def load_merchants(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @merchants << Merchant.new(data, self)
    end
  end

  def find_by_id(id)
    @merchants.find { |merchant| merchant.id == id }
  end

  def find_by_name(name)
    @merchants.find { |merchant| merchant.name.downcase == name.downcase }
  end

  def find_all_by_name(name)
    @merchants.find_all do |merchant|
      merchant.name.downcase.include?(name.to_s.downcase)
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def pass_id_to_se(id)
    @parent.pass_id_to_item_repo(id)
  end

  def pass_id_to_se_for_invoice(id)
    @parent.pass_id_to_invoice_repo(id)
  end

  def pass_customer_id_to_se(ids)
    ids.map do |id|
      @parent.customers.find_by_id(id)
    end.uniq
  end
end
