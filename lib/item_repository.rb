require_relative '../lib/item.rb'
require_relative '../lib/repo_method_helper.rb'
require 'csv'

class ItemRepository
  include RepoMethodHelper

  attr_reader :list

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
    @list << Item.new({
      id: create_id,
      created_at: Time.now.to_s,
      updated_at: Time.now.to_s,
      name: attributes[:name],
      description: attributes[:description],
      unit_price: attributes[:unit_price],
      merchant_id: attributes[:merchant_id]
      })
  end

  def update(id, attributes)
    new_name = attributes[:name]
    find_by_id(id).name = new_name unless new_name.nil?
    new_description = attributes[:description]
    find_by_id(id).description = new_description unless new_description.nil?
    new_unit_price = attributes[:unit_price]
    find_by_id(id).unit_price = new_unit_price unless new_unit_price.nil?
    find_by_id(id).updated_at = Time.now unless find_by_id(id).nil?
  end
end
