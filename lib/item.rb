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
    @unit_price = item_info[:unit_price]
    @created_at = item_info[:created_at]
    @updated_at = item_info[:updated_at]
    @merchant_id = item_info[:merchant_id].to_i
    @repo = repo
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  def create
    biggest = @all.max_by do |item|
      item.id
    end
    item[:id] = biggest.id + 1
    item[:name] = attributes[:name]
    item[:description] = attributes[:description]
    item[:unit_price] = attributes[:unit_price]
    item[:created_at] = Time.now
  end

  def update(item)
    @name = item[:name]
    @description = item[:description]
    @unit_price = item[:unit_price]
    @updated_at = Time.now
  end
end
