module Search

  def find_instance_by_id(list, search_id)
    search_id = search_id.to_i
    list.find do |object|
      search_id == object.id
    end
  end

  def find_instance_by_name(list, search_name)
    search_name = search_name.downcase
    list.find do |object|
      item_name = object.name.downcase
      item_name == search_name
    end
  end

  def find_all_instances_by_merchant_id(list, search_merchant_id)
    search_merchant_id = search_merchant_id.to_i
    list.find_all do |object|
      object.merchant_id == search_merchant_id
    end
  end

end
