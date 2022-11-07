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

  # def self.item_breakdown(items_entered)
  #   items_raw = CSV.open(items_entered, headers: true, header_converters: :symbol)
  #   item_repo = ItemRepository.new
  #   items_raw.each do |item|
  #     item_repo.add(item)
  #   end
  #   item_repo
  # end

  # def self.merchant_breakdown(merchants_entered)
  #   merchant_repo = MerchantRepository.new
  #   CSV.foreach(merchants_entered, headers: true, header_converters: :symbol) do |merchant|
  #     merchant_repo.add(merchant)
  #   end
  #   merchant_repo
  # end

  # def self.invoice_breakdown(invoices_entered)
  #   invoices_raw = CSV.open(invoices_entered, headers: true, header_converters: :symbol)
  #   invoice_repo = InvoiceRepository.new
  #   invoices_raw.each do |invoice|
  #     invoice_repo.add(invoice)
  #   end
  #   invoice_repo
  # end

  # def self.invoice_item_breakdown(invoice_items_entered)
  #   invoice_items_raw = CSV.open(invoice_items_entered, headers: true, header_converters: :symbol)
  #   invoice_item_repo = InvoiceItemRepository.new
  #   invoice_items_raw.each do |invoice_item|
  #     invoice_item_repo.add(invoice_item)
  #   end
  #   invoice_item_repo
  # end

  # def self.customer_breakdown(customers_entered)
  #   customers_raw = CSV.open(customers_entered, headers: true, header_converters: :symbol)
  #   customer_repo = CustomerRepository.new
  #   customers_raw.each do |customer|
  #     customer_repo.add(customer)
  #   end
  #   customer_repo
  # end

  # def self.transaction_breakdown(transactions_entered)
  #   transactions_raw = CSV.open(transactions_entered, headers: true, header_converters: :symbol)
  #   transaction_repo = TransactionRepository.new
  #   transactions_raw.each do |transaction|
  #     transaction_repo.add(transaction)
  #   end
  #   transaction_repo
  # end

  def analyst
    SalesAnalyst.new(@items, @merchants, @invoices, @invoice_items, @customers, @transactions)
  end
end
