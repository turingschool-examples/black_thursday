require 'csv'
require './lib/item'

class ItemsRepository
  attr_reader :repository

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
  end #initialize end

  def all
    @repository
  end

  def find_by_id(id)
    @repository.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @repository.find do |item|
      item.name == name
    end
  end

end
