require 'csv'
require_relative 'item'
require 'pry'
require_relative 'repository1'

class ItemRepository < Repository
# include FilePath
  attr_reader :items
  # @repo.test

  def initialize
    @repo = []
  end

  def all
    @repo
  end

  def find_by_id(id)
    @repo.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @repo.find do |item|
      item.name.casecmp?(name)
    end
  end

  def find_all_with_description(description)
    @repo.find_all do |item|
      item.description.casecmp?(description)
    end
  end

  def find_all_by_price(price)
    @repo.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @repo.find_all do |item|
      range === item.unit_price
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @repo.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def create(attributes)
    attributes[:id] ||= new_id(attributes)
    new_item = Item.new(attributes)
    @repo << new_item
    new_item
  end

  def new_id(attributes)
    unless @repo.empty?
      attributes[:id] = all.max do |item|
        item.id
      end.id + 1
    end
  end

  # def parse_data(file)
  #   rows = CSV.open file, headers: true, header_converters: :symbol
  #   rows.each do |row|
  #     new_obj = Item.new(row.to_h)
  #     repo << new_obj
  #   end
  # end

  def update(id, attributes)
    find_by_id(id).update(attributes) unless find_by_id(id).nil?
  end

  def delete(id)
    @repo.delete_if { |item| item.id == id }
  end

  def inspect
    "#<#{self.class} #{@repo.size} rows>"
  end
end
