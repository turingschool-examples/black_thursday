module IDManager
  def find_by_id(id)
    @all.find{|index| index.id == id}
  end

  def find_by_name(search)
  end

  def create(attributes)
  end

  def update(id, attributes)
  end

  def delete(id)
  end
end
