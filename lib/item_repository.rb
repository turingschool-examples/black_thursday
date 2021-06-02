require 'csv'
require 'bigdecimal'
require_relative '../lib/item'

class ItemRepository
  attr_reader :all

  def initialize(path)
    create_items(path)
    @all = [] #path create_items(path) - will need to update but tests need updated for mocks and specs
    @engine = engine
  end

  def create_items(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      item = Item.new({
                        :id           => row[:id].to_i,
                        :name         => row[:name],
                        :description  => row[:description],
                        :unit_price   => BigDecimal(row[:unit_price],4),
                        :merchant_id  => row[:merchant_id],
                        :created_at   => Time.now,
                        :updated_at   => Time.now
                        })
      @all << item #will be removed after test update
    end
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  def find_by_id(id)
    require 'pry'; binding.pry
    @all.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @all.find do |item|
      item.name.casecmp?(name)
    end
  end

  def find_all_with_description(description)
    @all.find_all do |item|
      item.description.casecmp?(description)
    end
  end

  def find_all_by_price(price)
    @all.find_all do |item|
      item.unit_price_to_dollars == price
    end
  end

  def find_all_by_price_in_range(range)
    @all.find_all do |item|
      range.include?(item.unit_price_to_dollars)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def create(attributes)
    new_id = @all.max_by do |item|
      item.id
    end
    item = Item.new({
                      :id           => new_id.id + 1,
                      :name         => attributes[:name],
                      :description  => attributes[:description],
                      :unit_price   => BigDecimal(attributes[:unit_price],4),
                      :created_at   => Time.now,
                      :updated_at   => Time.now,
                      :merchant_id  => attributes[:merchant_id]
                    })
    @all << item
    item
  end

  def update(id, attributes)
    info_edit             = find_by_id(id)
    info_edit.name        = attributes[:name]
    info_edit.description = attributes[:description]
    info_edit.unit_price  = BigDecimal(attributes[:unit_price], 4)
    info_edit.updated_at  = Time.now
  end

  def delete(id)
    delete_item = find_by_id(id)
    @all.delete(delete_item)
  end
end
