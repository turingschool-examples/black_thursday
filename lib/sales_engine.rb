require 'requirements'

class SalesEngine
  
  attr_reader :items, 
              :merchants, 
              :customers,
              :invoices,
              :invoice_items,
              :transactions

  def initialize(hash)
    @items      = ItemRepository.new(hash[:items], self)
    @merchants  = MerchantRepository.new(hash[:merchants], self)
    @customers  = CustomerRepository.new(hash[:customers], self)
    @invoices   = InvoiceRepository.new(hash[:invoices], self)
    @invoice_items = InvoiceItemRepository.new(hash[:invoice_items], self)
    @transactions  = TransactionRepository.new(hash[:transactions], self)
  end

  def self.from_csv(hash)
    new(hash)
  end

  def analyst
    SalesAnalyst.new(self)
  end
  
  def find_by_merchant_id(id)
    @merchants.find_by_id(id)
  end
end
