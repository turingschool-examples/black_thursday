module Search
  def find_by_id(id, list)
    list.find_all { |item| item.id == id }
  end

  def find_by_name(name)

  end

  def find_all_by_name(name)
  end

  def all

  end
end
