require 'csv'
require 'bigdecimal'
require 'time'
require_relative 'item'
require_relative 'helper_methods'

class ItemRepository
  include HelperMethods
  attr_reader :all, :engine

  def initialize(file_path, engine)
    @file_path = file_path.to_s
    @engine = engine
    @all = Array.new
    create_items
  end

  def create_items
    data = CSV.parse(File.read(@file_path), headers: true, header_converters: :symbol) do |line|
      @all << Item.new(line.to_h, self)
    end
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def find_all_with_description(description)
    result = @all.select do |line|
      line.description.to_s.downcase.include?(description.to_s.downcase)
    end
  end

  def find_all_by_price(price)
    result = @all.select do |line|
      line.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    result = @all.select do |line|
      range.include?(line.unit_price)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    result = @all.select do |line|
      line.merchant_id.to_i == merchant_id.to_i
    end
  end

  def create(attributes)
    @all << Item.new(
      {
        :id => create_new_id,
        :name => attributes[:name],
        :description => attributes[:description],
        :unit_price => attributes[:unit_price],
        :created_at => attributes[:created_at],
        :updated_at => attributes[:updated_at],
        :merchant_id => attributes[:merchant_id]
      }, self
    )
  end

  def update(id, attributes)
    result = find_by_id(id)
    unless result == nil
      @all.delete(result)
      result.name = attributes[:name] if attributes[:name] != nil
      result.description = attributes[:description] if attributes[:description] != nil
      result.unit_price = attributes[:unit_price] if attributes[:unit_price] != nil
      result.updated_at = Time.now
      @all << result
    end
  end

end
