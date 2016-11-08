require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'sales_analyst'
require_relative 'invoice_item_repository'
require_relative 'customer_repository'
require_relative 'transaction_repository'
require 'csv'
require 'pry'

class SalesEngine
  attr_reader   :merchants,
                :items,
                :invoices,
                :invoice_items,
                :transactions,
                :customers,
                :raw_data

  def initialize(all_file_paths)
    read_csv(all_file_paths)
    @merchants     = MerchantRepository.new(raw_data[:merchants], self)
    @items         = ItemRepository.new(raw_data[:items], self)
    @invoices      = InvoiceRepository.new(raw_data[:invoices], self)
    @invoice_items = InvoiceItemRepository.new(raw_data[:invoice_items], self)
    @transactions  = TransactionRepository.new(raw_data[:transactions], self)
    @customers     = CustomerRepository.new(raw_data[:customers], self)
  end

  def find_all_items_by_merchant_id(merchant_id)
    items.find_all_by_merchant_id(merchant_id)
  end

  def find_all_invoices_by_merchant_id(merchant_id)
    invoices.find_all_by_merchant_id(merchant_id)
  end

  def self.from_csv(all_file_paths)
    SalesEngine.new(all_file_paths)
  end

  def read_csv(file_path)
    @raw_data = {}
    if file_path != nil
      file_path.map do |key, value|
        raw_data[key] = CSV.read value, headers:true, header_converters: :symbol
      end
    else
      raise ArgumentError
    end
  end

end