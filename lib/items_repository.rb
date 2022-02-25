require 'csv'
require './lib/item'
require 'pry'

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

  def find_all_with_description(description)
    @repository.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    @repository.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range_start, range_end)
    @repository.find_all do |item|
      item.unit_price.to_i.between?(range_start.to_i, range_end.to_i)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @repository.find_all do |item|
      item.merchant_id ==  merchant_id
    end
  end

  def create(attributes)
    attributes[:id] = (@repository.last.id.to_i + 1).to_s
    item = Item.new(attributes)
    @repository << item
    item
  end

  def update(id, attributes)
    item = find_by_id(id)
    item.name = attributes[:name]
    item.description = attributes[:description]
    item.unit_price = attributes[:unit_price]
    item.updated_at = Time.now
  end

end
