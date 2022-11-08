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

  def destination(method)
    return @invoices if invoices.respond_to?(method)
    return @merchants if merchants.respond_to?(method)
    return @items if items.respond_to?(method)
    return @invoice_items if invoice_items.respond_to?(method)
    return @transactions if transactions.respond_to?(method)
    return @customers if customers.respond_to?(method)
  end

  # Generic helper method for sending method calls to correct Repo.
  def send_to_repo(message = {})
    if message[:destination].nil?
      destination(message[:method]).send(message[:method], *message[:args])
    else
      instance_variable_get("@#{message[:destination]}").send(message[:method], *message[:args])
    end
  end
end
