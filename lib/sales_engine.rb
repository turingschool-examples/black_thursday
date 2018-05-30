require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'sales_analyst'
require_relative 'invoice_item_repository'
require 'csv'
require 'pry'
class SalesEngine
  attr_reader :items,
              :merchants,
              :analyst,
              :invoices,
              :invoice_items


  def self.from_csv(sales_data)
    merchant_data = CSV.open(sales_data[:merchants], headers: true, header_converters: :symbol)
    item_data = CSV.open(sales_data[:items], headers: true, header_converters: :symbol)
    invoice_data = CSV.open(sales_data[:invoices], headers: true, header_converters: :symbol)
    invoice_item_data = CSV.open(sales_data[:invoice_items], headers: true, header_converters: :symbol)
    engine = SalesEngine.new
    engine.create_merchant_repo(merchant_data)
    engine.create_item_repo(item_data)
    engine.create_invoice_repo(invoice_data)
    engine.create_sales_analyst(engine)
    engine.create_invoice_item_repo(invoice_item_data)
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

  def create_invoice_item_repo(invoice_item_data)
    @invoice_items = InvoiceItemRepository.new
    invoice_item_data.each do |invoice_item|
      @invoice_items.create({id: invoice_item[:id], item_id: invoice_item[:item_id],
                        invoice_id: invoice_item[:invoice_id],
                        quantity: invoice_item[:quantity],
                        unit_price: invoice_item[:unit_price],
                        created_at: invoice_item[:created_at],
                        updated_at: invoice_item[:updated_at]})
      end
  end



  def create_sales_analyst(parent)
    @analyst = SalesAnalyst.new(parent)
  end


end
