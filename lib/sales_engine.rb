require 'csv'
require_relative 'merchant_repository.rb'
require_relative 'item_repository.rb'
require_relative 'invoice_repository'


class SalesEngine
  attr_reader :items, :merchants, :invoices
  def self.from_csv(hash)
    SalesEngine.new(hash)
  end

  def initialize(hash)
    @items = ItemRepository.new(hash[:items], self)
    @merchants = MerchantRepository.new(hash[:merchants], self)
    @invoices = InvoiceRepository.new(hash[:invoices], self)
  end

  def item_repo_finds_all_by_merchant_id(id)
    @items.find_all_by_merchant_id(id)
  end

  def merch_repo_find_all_by_id(id)
    @merchants.find_by_id(id)
  end
end
