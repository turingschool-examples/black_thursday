require 'csv'

class SalesEngine
  attr_reader

  def initialize(items, merchants)
    @items = items
    @merchants = merchants
  end

  def self.from_csv(csv_hash)
    items_input = CSV.open(csv_hash[:items], headers: true, header_converters: :symbol)
    merchants_input = CSV.open(csv_hash[:merchants], headers: true, header_converters: :symbol)
    se = SalesEngine.new(items_input, merchants_input)
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
