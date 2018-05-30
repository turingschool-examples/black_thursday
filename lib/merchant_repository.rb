require 'csv'
require_relative 'merchant'
require_relative 'repository'

# Merchant Repo
class MerchantRepository
  include Repository
  attr_reader :engine,
              :csv_items

  def initialize(filepath, parent = nil)
    @csv_items = []
    @engine    = parent
    load_children(filepath)
  end

  def merchants
    @csv_items
  end

  def child
    Merchant
  end

  def find_by_name(name)
    merchants.find { |merchant| merchant.name.casecmp(name.downcase).zero? }
  end

  def find_all_by_name(name)
    merchants.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def find_items_by_merchant_id(id)
    engine.find_items_by_merchant_id(id)
  end

  def find_invoices_by_merchant_id(id)
    engine.find_invoices_by_merchant_id(id)
  end
end
