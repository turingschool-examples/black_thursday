require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'
require_relative 'sales_analyst'
require 'bigdecimal'
require 'bigdecimal/util'
require 'time'
require 'csv'

class SalesEngine
  attr_reader :merchants,
              :items,
              :invoices,
              :invoice_items,
              :transactions,
              :customers,
              :analyst

  def self.from_csv(sales_data)
    merchant_data = CSV.open(sales_data[:merchants], headers: true, header_converters: :symbol)
    item_data = CSV.open(sales_data[:items], headers: true, header_converters: :symbol)
    invoice_data = CSV.open(sales_data[:invoices], headers: true, header_converters: :symbol)
    invoice_item_data = CSV.open(sales_data[:invoice_items], headers: true, header_converters: :symbol)
    transaction_data = CSV.open(sales_data[:transactions], headers: true, header_converters: :symbol)
    customer_data = CSV.open(sales_data[:customers], headers: true, header_converters: :symbol)
    engine = SalesEngine.new
    engine.create_merchant_repository(merchant_data)
    engine.create_item_repository(item_data)
    engine.create_invoice_repository(invoice_data)
    engine.create_invoice_item_repository(invoice_item_data)
    engine.create_transaction_repository(transaction_data)
    engine.create_customer_repository(customer_data)
    engine.create_sales_analyst(engine)
    return engine
  end

  def create_merchant_repository(merchant_data)
    @merchants = MerchantRepository.new
    merchant_data.each do |merchant|
      @merchants.create(id: merchant[:id],
                        name: merchant[:name],
                        created_at: merchant[:created_at],
                        updated_at: merchant[:updated_at])
    end
  end

  def create_item_repository(item_data)
    @items = ItemRepository.new
    item_data.each do |item|
      @items.create(id: item[:id],
                    name: item[:name],
                    description: item[:description],
                    unit_price: item[:unit_price],
                    created_at: item[:created_at],
                    updated_at: item[:updated_at],
                    merchant_id: item[:merchant_id])
    end
  end

  def create_invoice_repository(invoice_data)
    @invoices = InvoiceRepository.new
    invoice_data.each do |invoice|
      @invoices.create(id: invoice[:id],
                       customer_id: invoice[:customer_id],
                       merchant_id: invoice[:merchant_id],
                       status: invoice[:status],
                       created_at: invoice[:created_at],
                       updated_at: invoice[:updated_at])
    end
  end

  def create_invoice_item_repository(invoice_item_data)
    @invoice_items = InvoiceItemRepository.new
    invoice_item_data.each do |invoice_item|
      @invoice_items.create(id: invoice_item[:id],
                            item_id: invoice_item[:item_id],
                            invoice_id: invoice_item[:invoice_id],
                            quantity: invoice_item[:quantity],
                            unit_price: invoice_item[:unit_price],
                            created_at: invoice_item[:created_at],
                            updated_at: invoice_item[:updated_at])
    end
  end

  def create_transaction_repository(transaction_data)
    @transactions = TransactionRepository.new
    transaction_data.each do |transaction|
      @transactions.create(id: transaction[:id],
                           invoice_id: transaction[:invoice_id],
                           credit_card_number: transaction[:credit_card_number],
                           credit_card_expiration_date: transaction[:credit_card_expiration_date],
                           result: transaction[:result],
                           created_at: transaction[:created_at],
                           updated_at: transaction[:updated_at])
    end
  end

  def create_customer_repository(customer_data)
    @customers = CustomerRepository.new
    customer_data.each do |customer|
      @customers.create(id: customer[:id],
                        first_name: customer[:first_name],
                        last_name: customer[:last_name],
                        created_at: customer[:created_at],
                        updated_at: customer[:updated_at])
    end
  end

  def create_sales_analyst(engine)
    @analyst = SalesAnalyst.new(engine)
  end
end
