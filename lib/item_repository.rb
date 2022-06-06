require 'time'
require 'CSV'
require_relative 'item'
require_relative '../modules/findable'
require_relative '../modules/changeable'

class ItemRepository
  include Findable
  include Changeable
  attr_reader :all

  def inspect
  "#<#{self.class} #{@merchants.size} rows>"
  end

  def initialize(file_path)
    @all = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
       @all << Item.new({id: row[:id], name: row[:name], description: row[:description], unit_price: row[:unit_price], merchant_id: row[:merchant_id], created_at: row[:created_at], updated_at: row[:updated_at]})
    end
  end

  def create(attributes)
  attributes[:id]= find_max_id + 1
  @all << Item.new(attributes)
  end


  def update(input_id, attributes)
    attributes.each do |attribute, value|
      if attribute.to_sym == :name
        find_by_id(input_id).name = value
      elsif attribute.to_sym == :description
        find_by_id(input_id).description = value
      elsif attribute.to_sym == :unit_price
        find_by_id(input_id).unit_price = BigDecimal(value,4)
      end
    end
    find_by_id(input_id).updated_at = Time.now if find_by_id(input_id).class == Item
  end

end
