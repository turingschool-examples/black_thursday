require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/customer_repository'
require_relative '../lib/transaction_repository'
require 'pry'


class SalesEngine

  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :customers,
              :transactions

  def initialize(csv_files)
    csv_files      = merge_in_given_csvs(csv_files)
    @invoices      = InvoiceRepository.new(csv_files[:invoices], self)
    @items         = ItemRepository.new(csv_files[:items], self)
    @merchants     = MerchantRepository.new(csv_files[:merchants], self)
    @invoice_items = InvoiceItemRepository.new(csv_files[:invoice_items], self)
    @customers     = CustomerRepository.new(csv_files[:customers], self)
    @transactions  = TransactionRepository.new(csv_files[:transactions], self)
  end

  def merge_in_given_csvs(given_csvs)
    default_csvs.merge(given_csvs)
  end

  def default_csvs
    {
      items: './data/blanks/items_blank.csv',
      merchants: './data/blanks/merchants_blank.csv',
      invoices: './data/blanks/invoices_blank.csv',
      invoice_items: './data/blanks/invoice_items_blank.csv',
      customers: './data/blanks/customers_blank.csv',
      transactions: './data/blanks/transactions_blank.csv'
    }
  end

  def self.from_csv(csv_files)
    new(csv_files)
  end

  def find_item_by_merchant_id(id)
    items.find_item(id)
  end

  def find_merchant_by_id(id)
    merchants.find_by_id(id)
  end

  def grab_array_of_merchant_items
    merchants.grab_array_of_items
  end

  def grab_array_of_merchant_invoices
    merchants.grab_array_of_invoices
  end

  def grab_all_merchants
    merchants.all
  end

  def grab_all_items
    items.all
  end

  def grab_all_invoices
    invoices.all
  end

end
