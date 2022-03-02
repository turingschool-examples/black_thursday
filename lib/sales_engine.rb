# frozen_string_literal: true

# sales_engine
require 'CSV'
require_relative 'item'
require_relative 'item_repository'
require_relative 'merchant'
require_relative 'merchant_repository'
require_relative 'invoice'
require_relative 'invoice_repository'
require_relative 'invoice_items'
require_relative 'invoice_items_repository'
require_relative 'transaction'
require_relative 'transaction_repository'
require_relative 'customer'
require_relative 'customer_repository'
require_relative 'sales_analyst'
require 'pry'

class SalesEngine
  attr_reader :data,
              :items,
              :merchants,
              :invoices,
              :invoice_items,
              :transactions,
              :customers

  def initialize(data)
    @data = data
    @items = nil
    @merchants = nil
    @invoices = nil
    @transactions = nil
    @customers = nil
    @invoice_items = nil
  end

  def self.from_csv(data)
    new(data)
  end

  def merchants
    @merchants ||= MerchantRepository.new(data[:merchants])
  end

  def items
    @items ||= ItemRepository.new(data[:items])
  end

  def invoices
    @invoices ||= InvoiceRepository.new(data[:invoices])
  end

  def transactions
    @transactions ||= TransactionRepository.new(data[:transactions])
  end

  def customers
    @customer ||= CustomerRepository.new(data[:customers])
  end

  def invoice_items
    @invoice_items ||= InvoiceItemsRepository.new(data[:invoice_items])
  end

  def analyst
    SalesAnalyst.new(@items, @merchants, @invoices, @transactions, @customers, @invoice_items)
  end
end
