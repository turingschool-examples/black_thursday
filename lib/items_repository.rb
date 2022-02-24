require 'csv'
require './lib/item'

class ItemsRepository
  attr_reader :respository

  def initialize(file)
    @items = CSV.read(file, headers: true, header_converters: :symbol)

    @repository = @items.map do |item_csv|
      Item.new({
        id: item_csv[:id],
        name: item_csv[:name],
        description: item_csv[:description],
        unit_price: item_csv[:unit_price],
        created_at: item_csv[:created_at],
        updated_at: item_csv[:updated_at],
        merchant_id: item_csv[:merchant_id]
        })
      end
  end

end
