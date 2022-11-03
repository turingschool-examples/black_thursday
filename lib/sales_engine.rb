require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'sales_analyst'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'

class SalesEngine
  attr_reader :items, :merchants, :invoices, :invoice_items, :transactions
  def initialize(data)
    @items = data[:items]
    @merchants = data[:merchants]
    @invoices = data[:invoices]
    @invoice_items = data[:invoice_items]
    @transactions = data[:transactions]
  end

  def self.from_csv(csv_hash)
    if csv_hash.keys.include?(:items)
      item_input_data = item_breakdown(csv_hash[:items])
    end

    if csv_hash.keys.include?(:merchants)
      merchant_input_data = merchant_breakdown(csv_hash[:merchants])
    end

    if csv_hash.keys.include?(:invoices)
      invoice_input_data = invoice_breakdown(csv_hash[:invoices])
    end

    if csv_hash.keys.include?(:invoice_items)
      invoice_item_input_data = invoice_item_breakdown(csv_hash[:invoice_items])
    end

    if csv_hash.keys.include?(:transactions)
      transaction_item_input_data = transaction_breakdown(csv_hash[:transactions])
    end

    SalesEngine.new({
      items: item_input_data,
      merchants: merchant_input_data,
      invoices: invoice_input_data,
      invoice_items: invoice_item_input_data
      transactions: transaction_item_input_data
      })
  end

  def self.item_breakdown(items_entered)
    items_raw = CSV.open(items_entered, headers: true, header_converters: :symbol)
    item_repo = ItemRepository.new
    items_raw.each do |item|
      item_repo.add({
        id: item[:id],
        name: item[:name],
        description: item[:description],
        unit_price: item[:unit_price],
        created_at: item[:created_at],
        updated_at: item[:updated_at],
        merchant_id: item[:merchant_id]
        })
    end
    item_repo
  end

  def self.merchant_breakdown(merchants_entered)
    merchants_raw = CSV.open(merchants_entered, headers: true, header_converters: :symbol)
    merchant_repo = MerchantRepository.new
    merchants_raw.each do |merchant|
      merchant_repo.add({
        id: merchant[:id],
        name: merchant[:name]
        })
    end
    merchant_repo
  end

  def self.invoice_breakdown(invoices_entered)
    invoices_raw = CSV.open(invoices_entered, headers: true, header_converters: :symbol)
    invoice_repo = InvoiceRepository.new
    invoices_raw.each do |invoice|
      invoice_repo.add({
        id: invoice[:id],
        customer_id: invoice[:customer_id],
        merchant_id: invoice[:merchant_id],
        status: invoice[:status],
        created_at: invoice[:created_at],
        updated_at: invoice[:updated_at]
        })
    end
    invoice_repo
  end

  def self.invoice_item_breakdown(invoice_items_entered)
    invoice_items_raw = CSV.open(invoice_items_entered, headers: true, header_converters: :symbol)
    invoice_item_repo = InvoiceItemRepository.new
    invoice_items_raw.each do |invoice_item|
      invoice_item_repo.add({
        id: invoice_item[:id],
        item_id: invoice_item[:item_id],
        invoice_id: invoice_item[:invoice_id],
        quantity: invoice_item[:quantity],
        unit_price: invoice_item[:unit_price],
        created_at: invoice_item[:created_at],
        updated_at: invoice_item[:updated_at]
        })
    end
    invoice_item_repo
  end

  def self.transaction_breakdown(transactions_entered)
    transactions_raw = CSV.open(transactions_entered, headers: true, header_converters: :symbol)
    transaction_repo = TransactionRepository.new
    transactions_raw.each do |transaction|
      transaction_repo.add({
        id: transaction[:id],
        invoice_id: transaction[:invoice_id],
        credit_card_number: transaction[:credit_card_number],
        credit_card_expiration_date: transaction[:credit_card_expiration_date],
        result: transaction[:result],
        created_at: transaction[:created_at],
        updated_at: transaction[:updated_at]
        })
    end
    transaction_repo
  end

  def analyst
    SalesAnalyst.new(self)
  end
end
