require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'load_data'
require          'csv'

class SalesEngine
  attr_reader :repo_rows
  attr_accessor :items, :merchants

  def initialize(repo_rows)
    start_up_engine(repo_rows)
  end

  def self.from_csv(csv_hash)
    repo_rows = csv_hash.map do |type, filename|
      [type, LoadData.load_data(filename)]
    end.to_h
    SalesEngine.new(repo_rows)
  end

  def start_up_engine(repo_rows)
    @items                = ItemRepository.new(repo_rows[:items])
    @merchants            = MerchantRepository.new(repo_rows[:merchants])
    @invoices             = InvoiceRepository.new(repo_rows[:invoices])
    items_to_merchants
    merchants_to_items
  end

  def items_to_merchants
    @merchants.all.map { |merchant|
      merchant.items = @items.find_all_by_merchant_id(merchant.id)}
  end

  def merchants_to_items
    @items.all.map { |item|
      item.merchant = @merchants.find_by_id(item.merchant_id)}
  end
end
