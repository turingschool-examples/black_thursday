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
              :customers,
              :analyst

  def initialize(data)
    @items = ItemRepository.new((CSV.read data[:items], headers: true, header_converters: :symbol), self)
    @merchants = MerchantRepository.new((CSV.read data[:merchants], headers: true, header_converters: :symbol), self)
    @invoice_items = InvoiceItemRepository.new((CSV.read data[:invoice_items], headers: true, header_converters: :symbol), self)
    @invoices = InvoiceRepo.new((CSV.read data[:invoices], headers: true, header_converters: :symbol), self)
    @transactions = TransactionRepo.new((CSV.read data[:transactions], headers: true, header_converters: :symbol), self)
    @customers = CustomerRepo.new((CSV.read data[:customers], headers: true, header_converters: :symbol), self)
    @analyst = SalesAnalyst.new(self)
  end

  def self.from_csv(data)
    SalesEngine.new(data)
  end

  def average_items_per_merchant
    @merchants.average_items_per_merchant
  end

  def number_of_items_per_merchant
    @merchants.number_of_items_per_merchant
  end
  
  def average_items_per_merchant_standard_deviation
    @merchants.average_items_per_merchant_standard_deviation
  end

  def number_of_invoices_per_merchant
    @merchants.number_of_invoices_per_merchant
  end

  def average_invoices_per_merchant
    @merchants.average_invoices_per_merchant.round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    @merchants.average_invoices_per_merchant_standard_deviation
  end
end
