require 'csv'
require 'time'
require_relative '../lib/item'
# require_relative '.pry'
require_relative '../lib/repository_aide'
require 'bigdecimal'

class ItemsRepository
  include RepositoryAide
  attr_reader :repository, :merchant_ids

  def initialize(file)
    @repository = read_csv(file).map do |item_csv|
      Item.new({
        id: item_csv[:id].to_i,
        name: item_csv[:name],
        description: item_csv[:description],
        unit_price: BigDecimal(item_csv[:unit_price], significant_numbers(item_csv[:unit_price])),
        created_at: item_csv[:created_at],
        updated_at: item_csv[:updated_at],
        merchant_id: item_csv[:merchant_id].to_i
        })
      end
    group_hash
  end #initialize end



  def group_hash
    @ids = @repository.group_by{|item| item.id}
    @names = @repository.group_by{|item| item.name}
    @descriptions = @repository.group_by {|item| item.description.downcase}
    @unit_prices = @repository.group_by {|item| item.unit_price}
    @merchant_ids = @repository.group_by {|item| item.merchant_id}
  end

  def find_by_name(name)
    return nil if find(@names, name).nil?
    find(@names, name).first
  end

  def find_all_with_description(description)
      @repository.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    return [] if find(@unit_prices, (price * 100)).nil?
    find(@unit_prices, (price * 100))
  end

  def find_all_by_price_in_range(range)
    @repository.find_all do |item|
      range.include?(item.unit_price / 100)
    end
    # @repository.find_all do |item|
    #   item.(unit_price.between?(range.begin, range.end)
    # end
  end

  def find_all_by_merchant_id(merchant_id)
    find(@merchant_ids, merchant_id)
  end

  def create(attributes)
    item = Item.new(create_attribute_hash(attributes))
    @repository << item
    item
  end

  def update(id, attributes)
    item = find_by_id(id)
    attributes.each do |key, value|
      find_by_id(id).instance_variable_set(key.to_s.insert(0, '@').to_sym, value)
    end
    item.updated_at = Time.now
  end
end
