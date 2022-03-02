
module AnalysisAide

  def num_times_items_ordered
    items_to_count = {}
    @iir.item_ids.each do |id, list|
      items_to_count[@ir.find_by_id(id)] = list.count
    end
    items_to_count
  end

  def merchant_items_hash
    merch_items = {}
    num_times_items_ordered.each do |item, count|
      merch_id = @mr.find_by_id(item.merchant_id)
      merch_items[merch_id] = {} if !merch_items.key?(merch_id)
      merch_items[merch_id][count] = [] if !merch_items[merch_id].key?(count)
      merch_items[merch_id][count] << item
    end
    merch_items
  end

  def find_merchant_revenue_by_items(merchant_id)
    revenue = {}
    merchant_items_hash[@mr.find_by_id(merchant_id)].each do |count, items|
      items.each {|item| revenue[item.unit_price * count] = item}
    end
    revenue
  end
end
