require 'csv'

class SalesEngine
  attr_reader

  def initialize(data)
    @items = data[:items]
    @merchants = data[:merchants]
    @invoices = data[:invoices]
  end

  def self.from_csv(csv_hash)
    if csv_hash.keys.include?(:items)
      items_input = CSV.open(csv_hash[:items], headers: true, header_converters: :symbol)
    end
    if csv_hash.keys.include?(:merchants)
      merchants_input = CSV.open(csv_hash[:merchants], headers: true, header_converters: :symbol)
    end
    if csv_hash.keys.include?(:invoices)
      invoices_input = CSV.open(csv_hash[:invoices], headers: true, header_converters: :symbol)
    end
    se = SalesEngine.new({items: items_input, merchants: merchants_input, invoices: invoices_input})
  end

  def merchants
    mr = MerchantRepository.new
    @merchants.each do |merchant|
      mr.add({id: merchant[:id], name: merchant[:name]})
    end
    mr
  end

  def items
    ir = ItemRepository.new
    @items.each do |item|
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
end
