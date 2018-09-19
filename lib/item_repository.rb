require 'CSV'
require_relative 'repo_module'

class ItemRepository
include RepoModule
attr_reader :repo

  def initialize(file_path)
    @repo = []
    load_items(file_path)
  end

  def load_items(file_path)
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @repo << Item.new(row)
    end
  end

  def find_all_with_description(item_description)
    @repo.find_all do |item|
      item.description.downcase.include?(item_description.downcase)
      end
  end

  def find_all_by_price(price)
    @repo.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @repo.find_all do |item|
      range.include?(item.unit_price)
    end
  end

  def create(attributes)
    attributes[:id] = @repo[-1].id + 1
    @repo << Item.new(attributes)
  end

  def update(id, attributes)
    item = find_by_id(id)
    item.name = attributes[:name] unless attributes[:name].nil?
    item.description = attributes[:description] unless attributes[:description].nil?
    item.unit_price = attributes[:unit_price] unless attributes[:unit_price].nil?
    item.updated_at = Time.now unless (attributes[:name].nil? && attributes[:description].nil? && attributes[:unit_price].nil?)
    item
  end

end
