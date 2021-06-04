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

  def new_id
    item_with_max_id = @repo.all.max_by do |item|
      item.id
    end
    require "pry"; binding.pry
    item_with_max_id.id += 1
  end
end
