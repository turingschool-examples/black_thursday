require './lib/spec_helper'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :transactions,
              :customers,
              :analyst

  def self.from_csv(data)
    SalesEngine.new(data)
  end

  def initialize(data)
    @items = ItemRepository.new(data[:items])
    @merchants = MerchantRepository.new(data[:merchants])
    @invoices = InvoiceRepository.new(data[:invoices])
    @invoice_items = InvoiceItemRepository.new(data[:invoice_items])
    @transactions = TransactionRepository.new(data[:transactions])
    @customers = CustomerRepository.new(data[:customers])
    @analyst = SalesAnalyst.new({
                                 :items => @items,
                                 :merchants => @merchants,
                                 :invoices => @invoices,
                                 :invoice_items => @invoice_items,
                                 :transactions => @transactions,
                                 :customers => @customers
                                 })
  end
end
