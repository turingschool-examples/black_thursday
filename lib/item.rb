require 'time'
require 'bigdecimal'

class Item
  attr_reader :item, :item_repo
<<<<<<< HEAD
  def initialize(item, item_repo)
    @item = item
    @item_repo = item_repo
=======
  def initialize(item, repo = nil)
    @item = item
    @item_repo = repo
>>>>>>> 8bb3d494e5c2962461bc8fa64c8b80f62a6ca0e1
  end

  def id
    item.fetch(:id).to_i
  end

  def name
    item.fetch(:name)
  end

  def description
    item.fetch(:description)
  end

  def unit_price
    BigDecimal.new(item.fetch(:unit_price).to_i)/100.0
  end

  def created_at
    Time.parse(item.fetch(:created_at))
  end

  def updated_at
    Time.parse(item.fetch(:updated_at))
  end

  def merchant_id
    item.fetch(:merchant_id).to_i
  end

  def unit_to_dollar
      unit_price.to_f
  end

  # def merchants
  #   item_repo.
  # end

end
