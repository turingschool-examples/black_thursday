require 'csv'
require_relative '../lib/item.rb'
require_relative '../lib/repo_method_helper.rb'
require 'pry'

class ItemRepository
  attr_reader :list
  include RepoMethodHelper

  def initialize(list)
    @list = list
  end

  def find_all_with_description(description)
    downcased_description = description.downcase
    @list.find_all do |item|
      item.description.downcase.include?(downcased_description)
    end
  end

  def find_all_by_price(price)
    @list.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @list.find_all do |item|
      range.include?(item.unit_price.to_f)
    end
  end

  def create(attributes)
    attributes[:id] = create_id
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    created = Item.new(attributes)
    @list << created
    created
  end

  def update(id, attributes)
    find_by_id(id).name = attributes[:name] unless attributes[:name].nil?
    find_by_id(id).description = attributes[:description] unless attributes[:description].nil?
    find_by_id(id).unit_price = attributes[:unit_price] unless attributes[:unit_price].nil?
    find_by_id(id).updated_at = Time.now unless find_by_id(id).nil?
  end

  def inspect
    "#<#{self.ItemRepository} #{@list.size} rows>"
  end
end
