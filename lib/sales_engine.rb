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
    if csv_hash.keys.include?(:items)
      item_input_data = ItemRepository.new(csv_hash[:items])
    end

    if csv_hash.keys.include?(:merchants)
      merchant_input_data = MerchantRepository.new(csv_hash[:merchants])
    end

    if csv_hash.keys.include?(:invoices)
      invoice_input_data = InvoiceRepository.new(csv_hash[:invoices])
    end

    if csv_hash.keys.include?(:invoice_items)
      invoice_item_input_data = InvoiceItemRepository.new(csv_hash[:invoice_items])
    end

    if csv_hash.keys.include?(:customers)
      customer_input_data = CustomerRepository.new(csv_hash[:customers])
    end

    if csv_hash.keys.include?(:transactions)
      transaction_input_data = TransactionRepository.new(csv_hash[:transactions])
    end

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
    SalesAnalyst.new(@items, @merchants, @invoices, @invoice_items, @customers, @transactions)
  end
end
