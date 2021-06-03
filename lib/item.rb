class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id,
              :repo

  def initialize(item_hash, repo)
    @id = item_hash['id'].to_i
    @name = item_hash['name']
    @description = item_hash['description']
    @unit_price = item_hash['unit_price']
    @created_at = item_hash['created_at']
    @updated_at = item_hash['updated_at']
    @merchant_id = item_hash['merchant_id']
    @repo = repo
  end

  def to_hash
    self_hash = Hash.new
    self_hash[:id] = @id
    self_hash[:name] = @name
    self_hash[:description] = @description
    self_hash[:unit_price] = @unit_price
    self_hash[:created_at] = @created_at
    self_hash[:updated_at] = @updated_at
    self_hash[:merchant_id] = @merchant_id
    self_hash
  end

  def unit_price_to_dollars
    hash = to_hash
    value = hash[:unit_price]
    value.to_f
  end
end
