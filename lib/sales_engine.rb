require './lib/helper'
#require './lib/csv_parser'

class SalesEngine

  include CsvParser

  attr_reader :merchants,
              :items,
              :invoices,
              :invoice_items,
              :transactions,
              :customers

  def initialize(files = {})
    @merchants = create_merchant_repository(files)
    @items = create_item_repository(files)
    @invoices = create_invoice_repository(files)
    @invoice_items = create_invoice_item_repository(files)
    @transactions = create_transaction_repository(files)
    @customers = create_customer_repository(files)
  end

  def self.from_csv(files)
    new(files)
  end

  def create_merchant_repository(files)
    if files.include?(:merchants)
      MerchantRepository.new(open_file(files[:merchants]), self)
    end
  end

  def create_item_repository(files)
    if files.include?(:items)
      ItemRepository.new(open_file(files[:items]), self)
    end
  end

  def create_invoice_repository(files)
    if files.include?(:invoices)
      InvoiceRepository.new(open_file(files[:invoices]), self)
    end
  end

  def create_invoice_item_repository(files)
    if files.include?(:invoice_items)
      InvoiceItemRepository.new(open_file(files[:invoice_items]), self)
    end
  end

  def create_transaction_repository(files)
    if files.include?(:transactions)
      TransactionRepository.new(open_file(files[:transactions]), self)
    end
  end

  def create_customer_repository(files)
    if files.include?(:customers)
      CustomerRepository.new(open_file(files[:customers]), self)
    end
  end
end