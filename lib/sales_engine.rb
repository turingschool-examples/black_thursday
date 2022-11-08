# frozen_string_literal: true

require_relative 'require_store'

class SalesEngine
  attr_reader :items, :merchants, :invoices, :invoice_items, :transactions, :customers

  def initialize(data)
    @items = data[:items]
    @merchants = data[:merchants]
    @invoices = data[:invoices]
    @invoice_items = data[:invoice_items]
    @customers = data[:customers]
    @transactions = data[:transactions]
  end

  def self.from_csv(csv_hash)
    item_input_data = ItemRepository.new(csv_hash[:items]) if csv_hash.keys.include?(:items)

    merchant_input_data = MerchantRepository.new(csv_hash[:merchants]) if csv_hash.keys.include?(:merchants)

    invoice_input_data = InvoiceRepository.new(csv_hash[:invoices]) if csv_hash.keys.include?(:invoices)

    if csv_hash.keys.include?(:invoice_items)
      invoice_item_input_data = InvoiceItemRepository.new(csv_hash[:invoice_items])
    end

    customer_input_data = CustomerRepository.new(csv_hash[:customers]) if csv_hash.keys.include?(:customers)

    transaction_input_data = TransactionRepository.new(csv_hash[:transactions]) if csv_hash.keys.include?(:transactions)

    SalesEngine.new({
                      items: item_input_data,
                      merchants: merchant_input_data,
                      invoices: invoice_input_data,
                      invoice_items: invoice_item_input_data,
                      customers: customer_input_data,
                      transactions: transaction_input_data
                    })
  end

  def analyst
    SalesAnalyst.new(self)
  end
end
