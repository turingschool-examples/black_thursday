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

  def delete(id)
    @list.reject! do |list_item|
      list_item.id == id
    end
  end

end
