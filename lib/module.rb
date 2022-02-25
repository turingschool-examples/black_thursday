module IDManager
  def find_by_id(id)
    @all.find{|index| index.id == id}
  end

  def find_by_name(search)
    @all.find{|index| index.name == search}
  end

  def create(attributes)

  end

  def update(id, attributes)
    updated_hash = attributes
    @all[@all.find_index{|index| index.id == id}].merge(updated_hash)
  end

  def delete(id)
  end
end
