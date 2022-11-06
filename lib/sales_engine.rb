require 'csv'
require 'time'
require_relative 'item'
require_relative 'merchant'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'sales_analyst'
require_relative 'invoice'
require_relative 'invoice_repository'
require_relative 'invoice_item'
require_relative 'invoice_item_repository'
require_relative 'transaction'
require_relative 'transaction_repository'
require_relative 'customer'
require_relative 'customer_repository'

class SalesEngine

  attr_reader :items,
              :merchants,
              :invoices,
              :analyst,
              :invoice_items,
              :transactions,
              :customers

  def initialize(csv_hash)
    if (csv_hash.has_key?(:items))
      @items = create_item_repo(csv_hash[:items])
    else
      @items = nil
    end

    if (csv_hash.has_key?(:merchants))
      @merchants = create_merchant_repo(csv_hash[:merchants])
    else
      @merchants = nil
    end

    if (csv_hash.has_key?(:invoices))
      @invoices = create_invoice_repo(csv_hash[:invoices])
    else
      @invoices = nil
    end

    if (csv_hash.has_key?(:invoice_items))
      @invoice_items = create_invoice_item_repo(csv_hash[:invoice_items])
    else
      @invoice_items = nil
    end

    if (csv_hash.has_key?(:transactions))
      @transactions = create_transaction_repo(csv_hash[:transactions])
    else
      @transactions = nil
    end

    if (csv_hash.has_key?(:customers))
      @customers = create_customer_repo(csv_hash[:customers])
    else
      @customers = nil
    end

    @analyst = SalesAnalyst.new(@items, @merchants, @invoices)
  end

  def self.from_csv(csv_hash)
    sales_engine = SalesEngine.new(csv_hash)
  end

  def create_item_repo(item_csv)
    items = []
    contents = CSV.open item_csv, headers: true, header_converters: :symbol
    contents.each do |row|
      items.push(Item.new({:id => row[:id].to_i,
                           :name => row[:name],
                           :description => row[:description],
                           :unit_price => (row[:unit_price].to_d * (10**(-2))),
                           :created_at => Time.parse(row[:created_at]),
                           :updated_at => Time.parse(row[:updated_at]),
                           :merchant_id => row[:merchant_id].to_i}))
    end
    item_repo = ItemRepository.new(items)
  end

  def create_merchant_repo(merchant_csv)
    merchants = []
    contents = CSV.open merchant_csv, headers: true, header_converters: :symbol
    contents.each do |row|
      merchants.push(Merchant.new({:id => row[:id].to_i,
                                   :name => row[:name]}))
    end
    merchant_repo = MerchantRepository.new(merchants)
  end

  def create_invoice_repo(invoice_csv)
    invoices = []
    contents = CSV.open invoice_csv, headers: true, header_converters: :symbol
    contents.each do |row|
      invoices.push(Invoice.new({:id => row[:id].to_i,
                           :name => row[:name],
                           :customer_id => row[:customer_id].to_i,
                           :merchant_id => row[:merchant_id].to_i,
                           :status => row[:status].to_sym,
                           :created_at => Time.parse(row[:created_at]),
                           :updated_at => Time.parse(row[:updated_at])}))
    end
    invoice_repo = InvoiceRepository.new(invoices)
  end

  def create_invoice_item_repo(invoice_items_csv)
    invoice_items = []
    contents = CSV.open invoice_items_csv, headers: true, header_converters: :symbol
    contents.each do |row|
      invoice_items.push(InvoiceItem.new({:id => row[:id].to_i,
                           :item_id => row[:item_id].to_i,
                           :invoice_id => row[:invoice_id].to_i,
                           :quantity => row[:quantity].to_i,
                           :unit_price => row[:unit_price].to_d * (10**(-2)),
                           :created_at => Time.parse(row[:created_at]),
                           :updated_at => Time.parse(row[:updated_at])}))
    end
    invoice_item_repo = InvoiceItemRepository.new(invoice_items)
  end

  def create_transaction_repo(transaction_csv)
    transactions = []
    contents = CSV.open transaction_csv, headers: true, header_converters: :symbol
    contents.each do |row|
      transactions.push(Transaction.new({:id => row[:id].to_i,
                           :invoice_id => row[:invoice_id].to_i,
                           :credit_card_number => row[:credit_card_number],
                           :credit_card_expiration_date => row[:credit_card_expiration_date],
                           :result => row[:result],
                           :created_at => Time.parse(row[:created_at]),
                           :updated_at => Time.parse(row[:updated_at])}))
    end
    transaction_repo = TransactionRepository.new(transactions)
  end

  def create_customer_repo(customer_csv)
    customers = []
    contents = CSV.open customer_csv, headers: true, header_converters: :symbol
    contents.each do |row|
      customers.push(Customer.new({:id => row[:id].to_i,
                           :first_name => row[:first_name],
                           :last_name => row[:last_name],
                           :created_at => Time.parse(row[:created_at]),
                           :updated_at => Time.parse(row[:updated_at])}))
    end
    customer_repo = CustomerRepository.new(customers)
  end
end
