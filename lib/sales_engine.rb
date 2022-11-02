require 'csv'
require_relative 'item'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'merchant'
require_relative 'sales_analyst'
class SalesEngine
  def initialize(data)
    @items = data[:items]
    @merchants = data[:merchants]
    @invoices = data[:invoices]
  end

  def self.from_csv(csv_hash)
    SalesEngine.new(csv_hash)
  end

  def merchants
    mr = MerchantRepository.new
    contents = CSV.open(@merchants, headers: true, header_converters: :symbol)
    contents.each do |merchant|
      mr.add({id: merchant[:id], name: merchant[:name]})
    end
    mr
  end
  def analyst
    SalesAnalyst.new(self)
  end
  def items
    ir = ItemRepository.new
    contents = CSV.open(@items, headers: true, header_converters: :symbol)
    contents.each do |item|
      ir.add({id: item[:id],
                name: item[:name],
                description: item[:description],
                unit_price: item[:unit_price],
                created_at: item[:created_at],
                updated_at: item[:updated_at],
                merchant_id: item[:merchant_id]
                })
    end
    ir
  end

  def invoices
    invr = InvoiceRepository.new
    contents = CSV.open(@invoices, headers: true, header_converters: :symbol)
    contents.each do |invoice|
      invr.add({id: invoice[:id],
                customer_id: invoice[:customer_id],
                merchant_id: invoice[:merchant_id],
                status: invoice[:status],
                created_at: invoice[:created_at],
                updated_at: invoice[:updated_at]
                })
    end
    invr
  end
end
