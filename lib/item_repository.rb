require 'csv'
require_relative '../lib/item'
require_relative '../lib/repository_helper'
require 'bigdecimal'

class ItemRepository
  include RepositoryHelper
  attr_reader :items,
              :all

  def initialize(filepath)
    @filepath = filepath
    @items = []
    @all= []
  end

  def create_items
    CSV.foreach(@filepath, headers: true, header_converters: :symbol) do |row|
      @all << Item.new(row)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def create(attributes)
    attributes[:id] = create_id
    item = Item.new(attributes)
    @all << item
  end

  def update(id, attributes)
    if find_by_id(id) != nil
      find_by_id(id).update_attributes(attributes)
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end

