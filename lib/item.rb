require 'time'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id,
              :repo

  def initialize(item_info, repo)
    @id = item_info[:id].to_i
    @name = item_info[:name]
    @description = item_info[:description]
    @unit_price = BigDecimal(item_info[:unit_price]) / 100
    @created_at = Time.parse(item_info[:created_at])
    @updated_at = Time.parse(item_info[:updated_at])
    @merchant_id = item_info[:merchant_id].to_i
    @repo = repo
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  def self.create(attributes, repo)
    item = Hash.new
    time = Time.now.utc.strftime("%m-%d-%Y %H:%M:%S %Z")
    item[:id] = repo.new_id_number
    item[:name] = attributes[:name]
    item[:description] = attributes[:description]
    item[:unit_price] = attributes[:unit_price]
    item[:created_at] = time
    item[:updated_at] = time
    new(item, repo)
  end

  def update(attributes)
    @name = attributes[:name]
    @description = attributes[:description]
    @unit_price = attributes[:unit_price]
    @updated_at = Time.now
  end
end
