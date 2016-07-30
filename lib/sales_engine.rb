require_relative 'item_repository'
require_relative 'merchant_repository'
require 'csv'

class SalesEngine
  attr_reader :items, :merchants

  def initialize(items_path, merchants_path)
    @items = ItemRepository.new(csv_rows(items_path), self)
    @merchants = MerchantRepository.new(csv_rows(merchants_path), self)
  end

  def csv_rows(path)
    file = CSV.open(path, headers: true, header_converters: :symbol)
    file.to_a
  end

  def self.from_csv(hash)
    items_path = hash[:items]
    merchants_path = hash[:merchants]
    self.new(items_path, merchants_path)
  end

  def find_merchant_by_id(m_id)
    merchants.find_by_id(m_id)
  end

  def find_all_items_by_merchant_id(m_id)
    items.find_all_by_merchant_id(m_id)
  end

  def all_merchants
    merchants.all
  end

  def total_merchants
    merchants.all.length
  end

  def items_by_merchant
    all_merchants.map { |m| find_all_items_by_merchant_id(m.id).length }
  end


end
