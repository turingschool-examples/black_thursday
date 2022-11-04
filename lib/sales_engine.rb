# frozen_string_literal: true

require 'csv'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_item_repository'
require_relative 'invoice_repo'
require_relative 'transaction_repo'
require_relative 'customer_repo'

# This is the SalesEngine class
class SalesEngine
  attr_reader :items,
              :merchants,
              :invoice_items,
              :invoices,
              :transactions,
              :customers

  def initialize(ir_data, mr_data, iir_data, invr_data, tr_data, cr_data)
    @items = ItemRepository.new(ir_data, self)
    @merchants = MerchantRepository.new(mr_data, self)
    @invoice_items = InvoiceItemRepository.new(iir_data, self)
    @invoices = InvoiceRepo.new(invr_data, self)
    @transactions = TransactionRepo.new(tr_data, self)
    @customers = CustomerRepo.new(cr_data, self)
    # @analyst = SalesAnalyst.new(self)
  end

  def self.from_csv(data)
    ir_data = CSV.read data[:items], headers: true, header_converters: :symbol
    mr_data = CSV.read data[:merchants], headers: true, header_converters: :symbol
    iir_data = CSV.read data[:invoice_items], headers: true, header_converters: :symbol
    invr_data = CSV.read data[:invoices], headers: true, header_converters: :symbol
    tr_data = CSV.read data[:transactions], headers: true, header_converters: :symbol
    cr_data = CSV.read data[:customers], headers: true, header_converters: :symbol
    SalesEngine.new(ir_data, mr_data, iir_data, invr_data, tr_data, cr_data)
  end

  def average_items_per_merchant
    @merchants.average_items_per_merchant
  end

  def number_of_items_per_merchant
    @merchants.number_of_items_per_merchant
  end

  def items_per_merchant
    @merchants.items_per_merchant
  end
end
