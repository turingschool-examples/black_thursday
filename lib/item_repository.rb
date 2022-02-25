require 'csv'
require 'date'
require_relative 'item'
require_relative 'sales_module'

class ItemRepository
  attr_reader :all
  def initialize(csv)
    @all = Item.read_file(csv)
  end

  def find_all_with_description(description)
    found = []
    found << @all.find_all{|item| item.description.downcase == description.downcase}
    found.flatten
  end

  def find_all_by_price(price)
    found = []
    found << @all.find_all{|item| item.unit_price.to_f == price}
    found.flatten
  end

  def find_all_by_price_in_range(range)
    found = []
    found << @all.find_all do |item|
      range.include?(item.unit_price.to_f)
    end
    return found.flatten
  end

  def find_all_by_merchant_id(merchant_id)
    found = []
    found << @all.find_all{|item| item.merchant_id == merchant_id}
    found.flatten
  end

  def create(attributes)
    new_item = Item.new({
      id: (@all[-1].id + 1),
      name: attributes[:name],
      description: attributes[:description],
      unit_price: attributes[:unit_price],
      merchant_id: attributes[:merchant_id],
      created_at: Date.today.to_s,
      updated_at: Date.today.to_s})
      @all << new_item
  end

  def update(id, attributes)
    updated_item = @all.find{|item| item.id == id}
    updated_item.name = attributes[:name]
    updated_item.description = attributes[:description]
    updated_item.unit_price = attributes[:unit_price]
    updated_item.updated_at = Date.today.to_s
  end

  include SalesModule

end
