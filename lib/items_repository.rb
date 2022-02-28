require 'csv'
require './lib/item'
require 'pry'
require './lib/repository_aide'

class ItemsRepository
  include RepositoryAide
  attr_reader :repository, :merchant_ids

  def initialize(file)
    @repository = read_csv(file).map do |item_csv|
      Item.new({
        id: item_csv[:id],
        name: item_csv[:name],
        description: item_csv[:description],
        unit_price: BigDecimal(item_csv[:unit_price], significant_numbers(item_csv[:unit_price])) 
        created_at: item_csv[:created_at],
        updated_at: item_csv[:updated_at],
        merchant_id: item_csv[:merchant_id]
        })
      end
    group
  end #initialize end

  def group
    @ids = @repository.group_by{|item| item.id}
    @names = @repository.group_by{|item| item.name}
    @descriptions = @repository.group_by {|item| item.description.downcase}
    @unit_prices = @repository.group_by {|item| item.unit_price}
    @merchant_ids = @repository.group_by {|item| item.merchant_id}
  end

  def find_by_name(name)
    find(@names, name)
  end

  def find_all_with_description(description)
      @repository.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    find(@unit_prices, price)
  end

  def find_all_by_price_in_range(range_start, range_end)
    @repository.find_all do |item|
      item.unit_price.to_i.between?(range_start.to_i, range_end.to_i)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    find(@merchant_ids, merchant_id)
  end

  def create(attributes)
    item = Item.new({
      id: new_id.to_s,
      name: attributes[:name],
      description: attributes[:description],
      unit_price: attributes[:unit_price],
      created_at: Time.now,
      updated_at: Time.now,
      merchant_id: attributes[:merchant_id]})
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
