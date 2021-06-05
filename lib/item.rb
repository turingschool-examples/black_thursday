class Item
  attr_reader  :id,
  :name,
  :description,
  :unit_price,
  :updated_at,
  :created_at,
  :merchant_id,
  :repo

  def initialize(info, repo)
    @id = info['id'].to_i
    @name = info['name']
    @description = info['description']
    @unit_price = info['unit_price'].to_f
    @created_at = info['created_at']
    @updated_at = info['updated_at']
    @merchant_id = info['merchant_id'].to_i
    @repo = repo
  end

  def unit_price_to_dollars
    '%.2f' % "#{@unit_price}"
  end

  # def self.make_item()
  # end
  def update_item(attributes)
    @name = attributes['name']
    @description = attributes['description']
    @unit_price = attributes['unit_price']
    @updated_at = Time.now
  end
end
