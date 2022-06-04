require 'helper'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :analyst

  def initialize(data)
    @items = check_items(data)
    @merchants = check_merchants(data)
    @invoices = check_invoices(data)
  end

  def self.from_csv(data)
    SalesEngine.new(data)
  end

<<<<<<< HEAD
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

=======
  def check_items(data)
    return ItemRepository.new(data[:items]) if data.keys.include?(:items) == true
  end

  def check_merchants(data)
    return MerchantRepository.new(data[:merchants]) if data.keys.include?(:merchants) == true
  end

  def check_invoices(data)
    return InvoiceRepository.new(data[:invoices]) if data.keys.include?(:invoices) == true
  end

  def analyst
    SalesAnalyst.new(@items, @merchants)
  end
>>>>>>> c06c19d4a02da98799ed6797763d95f47757c008
end
