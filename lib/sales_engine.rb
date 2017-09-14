require_relative 'merchant_repo'
require_relative 'item_repo'
require_relative 'invoice_repo'
require 'pry'

class SalesEngine
  attr_reader :merchant_repo, :item_repo, :invoice_repo

  def self.from_csv(data_hash)
    new(data_hash)
  end

  def initialize(data_hash)
    @merchant_repo = MerchantRepo.new(data_hash[:merchants],self)
    @item_repo = ItemRepo.new(data_hash[:items],self)
    @invoice_repo = InvoiceRepo.new(data_hash[:invoices],self)
  end

  def merchants
    merchant_repo
  end

  def items
    item_repo
  end

  def invoices
    invoice_repo
  end

  def merchant_items(id)
    item_repo.find_all_by_merchant_id(id)
  end

  def item_merchant(id)
    merchant_repo.find_by_id(id)
  end

  def invoice_merchant(id)
    merchant_repo.find_by_id(id)
  end

end
