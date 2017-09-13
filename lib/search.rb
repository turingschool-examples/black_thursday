module Search

  def find_instance_by_id(list, search_id)
    search_id = search_id.to_s
    list.find do |list_item|
      search_id == list_item.id
    end
  end

  def find_instance_by_name(list, search_name)
    search_name = search_name.downcase
    list.find do |list_item|
      item_name = list_item.name.downcase
      item_name == search_name
    end
  end
  
end
