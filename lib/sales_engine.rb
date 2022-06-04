require 'helper'

class SalesEngine
  attr_reader :item_repository,
              :merchant_repository,
              :invoice_repository

  def initialize(items_path, merchants_path, invoices_path)
    @item_repository = ItemRepository.new(items_path)
    @merchant_repository = MerchantRepository.new(merchants_path)
    @invoice_repository = InvoiceRepository.new(invoices_path)
  end

  def self.from_csv(data)
    SalesEngine.new(data[:items], data[:merchants], data[:invoices])
  end

  def merchants
    @merchant_repository
  end

  def items
    @item_repository
  end

  def invoices
    @invoice_repository
  end

  def analyst
    SalesAnalyst.new(@item_repository,@merchant_repository,@invoice_repository)
  end

end
