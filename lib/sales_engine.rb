require 'csv'
require 'pry'
require_relative '../lib/merchantrepository'
require_relative '../lib/item_repository'
require_relative '../lib/invoice_repository'
class SalesEngine
  attr_reader :items,
              :merchants,
              :analyst,
              :invoices
              

  def self.from_csv(sales_data)
    merchant_data = CSV.open(sales_data[:merchants], headers: true, header_converters: :symbol)
    invoice_data = CSV.open(sales_data[:invoices], headers: true, header_converters: :symbol)
    item_data = CSV.open(sales_data[:items], headers: true, header_converters: :symbol)
    engine = SalesEngine.new
    engine.create_merchant_repo(merchant_data)
    engine.create_item_repo(item_data)
    engine.create_invoice_repo(invoice_data)
    engine.create_sales_analyst(engine)
    return engine
  end

  def create_merchant_repo(merchant_data)
    @merchants = MerchantRepository.new
    merchant_data.each do |merchant|
      @merchants.create({id: merchant[:id], name: merchant[:name], created_at: merchant[:created_at], updated_at: merchant[:updated_at]})
    end
  end

  def create_item_repo(item_data)
    @items = ItemRepository.new
    item_data.each do |item|
      @items.create({id: item[:id], name: item[:name],
                        description: item[:description],
                        unit_price: item[:unit_price],
                        created_at: item[:created_at],
                        updated_at: item[:updated_at],
                        merchant_id: item[:merchant_id]})
    end
  end

  def create_invoice_repo(invoice_data)
    @invoices = InvoiceRepository.new
    invoice_data.each do |invoice|
      @invoices.create({id: invoice[:id], customer_id: invoice[:customer_id],
                        merchant_id: invoice[:merchant_id],
                        status: invoice[:status],
                        created_at: invoice[:created_at],
                        updated_at: invoice[:updated_at]})
      end
  end


  def create_sales_analyst(parent)
    @analyst = SalesAnalyst.new(parent)
  end


end
