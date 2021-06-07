module Countable
  def items_by_merch_count
    merch_items_hash.values.map do |item_array|
      item_array.count
    end
  end
end
