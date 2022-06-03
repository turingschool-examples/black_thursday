require 'helper'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :analyst

  def initialize(data)
    @items = ItemRepository.new(data[:items])
    @merchants = MerchantRepository.new(data[:merchants])
    @invoices = InvoiceRepository.new(data[:invoices])
    @analyst = SalesAnalyst.new
  end

  def self.from_csv(data)
    SalesEngine.new(data)
  end

  # def analyst
  #   @sales_analyst
  # end
  #
  # def merchants
  #   @merchants
  # end
  #
  # def items
  #   @items
  # end
  #
  # def invoices
  #   @invoice_repository
  # end
end
