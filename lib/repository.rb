module Repository

  def all
    @list
  end

  def find_by_id(id)
    @list.find do |list_item|
      list_item.id == id
    end
  end

  def find_by_name(name)
    @list.find do |list_item|
      list_item.name.downcase == name.downcase
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @list.find_all do |list_item|
      list_item.merchant_id == merchant_id
    end
  end

  def find_all_by_item_id(item_id)
    @list.find_all do |list_item|
      list_item.item_id == item_id
    end
  end

  def find_highest_id
    highest_list_id = @list.max_by do |list_item|
      list_item.id
    end
  end

  def delete(id)
    @list.reject! do |list_item|
      list_item.id == id
    end
  end

  def inspect
    "#<#{self.class} #{@list.size} rows>"
  end
end
