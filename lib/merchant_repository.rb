require 'csv'
require_relative 'merchant'
require_relative 'parser'

class MerchantRepository
  include Parser
  attr_reader :all,
              :parent

  def initialize(file_path, parent)
    @all    = create_merchants(file_path)
    @parent = parent
  end

  def create_merchants(file_path)
    data_rows = parse_merchants_csv(file_path)
    data_rows.map { |row| Merchant.new(row, self) }
  end

  def find_by_id(desired_id)
    all.find { |m| m.id == desired_id }
  end

  def find_by_name(desired_name)
    all.find { |m| m.name.downcase == desired_name.downcase }
  end

  def find_all_by_name(desired_name_frag)
    all.find_all { |m| m.name.downcase.include?(desired_name_frag.downcase) }
  end

  def find_items_by_merchant_id(id)
    parent.find_items_by_merchant_id(id)
  end

  def merchant_item_count
    all.map {|m| m.items.count }
  end

  def find_invoices_by_merchant_id(id)
    parent.find_invoices_by_merchant_id(id)
  end

  def find_customer_by_customer_id(customer_id)
    parent.find_customer_by_id(customer_id)
  end

  def inspect
  end
end