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
    @id = info['id']
    @name = info['name']
    @description = info['description']
    @unit_price = info['unit_price']
    @created_at = info['created_at']
    @updated_at = info['updated_at']
    @merchant_id = info['merchant_id']
    @repo = repo
  end

  def unit_price_to_dollars
    '%.2f' % "#{@unit_price}"
  end
end
