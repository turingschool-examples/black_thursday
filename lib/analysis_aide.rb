
module AnalysisAide

  def num_times_items_ordered
    items_to_count = {}
    @iir.item_ids.each do |id, list|
      items_to_count[@ir.find_by_id(id)] = list.count
    end
    items_to_count
  end



end
