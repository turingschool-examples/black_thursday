require 'CSV'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'

class SalesEngine
  attr_reader :items, :merchants, :invoices

  def initialize(file_location)
    @item_repository = ItemRepository.new(file_location[:items], self).create_repo
    @merchant_repository = MerchantRepository.new(file_location[:merchants], self).create_repo
    @invoice_repository = InvoiceRepository.new(file_location[:invoices], self).create_repo
  end

  def self.from_csv(file_location)
    SalesEngine.new(file_location)
  end

  def merchants
    @merchant_repository
  end

  def find_merchant_by_id(id)
    @merchant_repository.find_by_id(id)
  end

  def items
    @item_repository
  end

  def find_item_by_id(id)
    @item_repository.find_by_id(id)
  end

  def analyst
    SalesAnalyst.new(self)
  end

  def invoices
    @invoice_repository
  end

  def find_invoice_by_id(id)
    @invoice_repository.find_by_id(id)
  end

end
