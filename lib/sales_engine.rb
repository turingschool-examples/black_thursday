require 'csv'
require './lib/merchant_repository'
require './lib/item_repository'
require './lib/invoice_repository'

class SalesEngine
  attr_accessor :items, :merchants, :invoices
  def initialize(data)
    @items = data[:items]
    @merchants = data[:merchants]
    @invoices = data[:invoices]
  end

  def self.from_csv(csv_hash)
    if csv_hash.keys.include?(:items)
      items_raw = CSV.open(csv_hash[:items], headers: true, header_converters: :symbol)
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
    end

    if csv_hash.keys.include?(:merchants)
      merchants_raw = CSV.open(csv_hash[:merchants], headers: true, header_converters: :symbol)
      merchant_repo = MerchantRepository.new
      merchants_raw.each do |merchant|
        merchant_repo.add({id: merchant[:id], name: merchant[:name]})
      end
    end

    if csv_hash.keys.include?(:invoices)
      invoices_raw = CSV.open(csv_hash[:invoices], headers: true, header_converters: :symbol)
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
    end

    SalesEngine.new({items: item_repo, merchants: merchant_repo, invoices: invoice_repo})
  end
end
