require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'

class SalesEngine
  attr_reader :items, :merchants, :invoices
  def initialize(data)
    @items = data[:items]
    @merchants = data[:merchants]
    @invoices = data[:invoices]
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

    SalesEngine.new({items: item_input_data, merchants: merchant_input_data, invoices: invoice_input_data})
  end

  def self.item_breakdown(items_entered)
    items_raw = CSV.open(items_entered, headers: true, header_converters: :symbol)
    item_repo = ItemRepository.new
    items_raw.each do |item|
      item_repo.add({id: item[:id],
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
      merchant_repo.add({id: merchant[:id], name: merchant[:name]})
    end
    merchant_repo
  end

  def self.invoice_breakdown(invoices_entered)
    invoices_raw = CSV.open(invoices_entered, headers: true, header_converters: :symbol)
    invoice_repo = InvoiceRepository.new
    invoices_raw.each do |invoice|
      invoice_repo.add({id: invoice[:id],
                customer_id: invoice[:customer_id],
                merchant_id: invoice[:merchant_id],
                status: invoice[:status],
                created_at: invoice[:created_at],
                updated_at: invoice[:updated_at]
                })
    end
    invoice_repo
  end

  def analyst
    SalesAnalyst.new(self)
  end
end
