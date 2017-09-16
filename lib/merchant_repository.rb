require_relative 'merchant'
require 'csv'

class MerchantRepository
  attr_accessor :all

  def initialize(file_path, parent=nil)
    @all    = create_merchants(file_path)
    @parent = parent
  end

  def csv_parse(file_path)
    CSV.open file_path, headers: true, header_converters: :symbol
  end

  def create_merchants(file_path)
    csv_parse(file_path).map {|row| Merchant.new(row, self)}
  end

  def find_by_id(item_id)
    all.find {|merchant| merchant.id.to_i == item_id.to_i}
  end

  def find_by_name(name)
    all.find {|merchant| merchant.name.downcase == name.downcase}
  end

  def find_all_by_name(fragment)
    all.select {|merchant| merchant.name.downcase.include?(fragment.downcase)}
  end

  def find_all_by_merchant_id(merchant_id)
    @parent.find_all_by_merchant_id(merchant_id)
  end

  def find_invoices_by_merchant_id(merchant_id)
    @parent.find_invoices_by_merchant_id(merchant_id)
  end

  def find_all_customers_per_merchant(id)
    @parent.find_all_customers_per_merchant(id)
  end

  def inspect
    "#{self.class}"
  end
end
