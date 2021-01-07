require 'CSV'
require './lib/sales_engine'

class Analyst

  def initialize(engine)
    @engine = engine
  end

  # def average_items_per_merchant
  #   grouped_hash = @engine.items.group_by_merchant_id.map do |merchant|
  #     merchant[1].count
  # end
  # end

  def average_items_per_merchant
    grouped_hash = @engine.items.group_by_merchant_id
    total_items = grouped_hash.values.flatten.count
    total_keys = grouped_hash.keys.count
    total_items.to_f / total_keys
  end
end
