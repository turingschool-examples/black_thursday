require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_analyst'
require_relative '../lib/invoice_repository'
require 'csv'
class SalesEngine
  attr_reader :items, :merchants, :analyst, :invoices
  def initialize(data)
    @item_data = CSV.open(data[:items], headers: true, header_converters: :symbol)
    @merchant_data = CSV.open(data[:merchants], headers: true, header_converters: :symbol)
    @invoice_data = CSV.open(data[:invoices], headers: true, header_converters: :symbol)
    @items_collection = []
    @merchants_collection = []
    @invoice_collection = []
    @items      = ItemRepository.new(create_items)
    @merchants  = MerchantRepository.new(create_merchants)
    @invoices   = InvoiceRepository.new(create_invoices)
    @analyst    = SalesAnalyst.new(@items, @merchants)
  end

  def self.from_csv(data)
    SalesEngine.new(data)
  end

  def create_items
    @item_data.each do |row|
      @items_collection << Item.new( {
               id: row[:id].to_i,
               name: row[:name].to_s,
               description: row[:description].to_s,
               unit_price: big_decimal_converter(row[:unit_price]),
               merchant_id: row[:merchant_id].to_i,
               created_at: row[:created_at].to_s,
               updated_at: row[:updated_at].to_s
                                      } )
    end
    @items_collection
  end

  def big_decimal_converter(price)
    significant_digits = price.to_s.length
    number = price.to_f / 100
    BigDecimal.new(number, significant_digits)
  end

  def create_merchants
    @merchant_data.each do |row|
      @merchants_collection << Merchant.new( {id: row[:id].to_i,
                                             name: "#{row[:name]}"} )
    end
    @merchants_collection
  end

  def create_invoices
    @invoice_data.each do |row|
      @invoice_collection << Invoice.new( {id: row[:id].to_i,
                                          customer_id: row[:customer_id].to_i,
                                          merchant_id: row[:merchant_id].to_i,
                                          status: row[:status].to_s,
                                          created_at: row[:created_at].to_s,
                                          updated_at: row[:updated_at].to_s
                                          } )
    end
    @invoice_collection
  end
end
