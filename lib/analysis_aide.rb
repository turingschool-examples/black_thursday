
module AnalysisAide

  def num_times_items_ordered
    items_to_count = {}
    @iir.item_ids.each do |id, list|
      items_to_count[@ir.find_by_id(id)] = list.count
    end
    items_to_count
  end

  def merchant_items_hash
    merchants_and_items = {}
    num_times_items_ordered.each do |item, count|
      merch_id = @mr.find_by_id(item.merchant_id)
      if !merchants_and_items.key?(merch_id)
        merchants_and_items[merch_id] = {}
      end
      if !merchants_and_items[merch_id].key?(count)
        merchants_and_items[merch_id][count] = []
      end
      merchants_and_items[merch_id][count] << item
    end
    merchants_and_items
  end




end
