module Repository

  def all
    @list
  end

  def find_by_id(id)
    @list.find do |list_item|
      list_item.id == id
    end
  end

end
