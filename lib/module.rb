module IDManager
  def find_by_id(id)
    @all.find{|index| index.id.to_i == id}
  end

  def find_by_name(search)
    @all.find{|index| index.name.upcase == search.upcase}
  end

  # def create(attributes)
  #   new_element = attributes
  #   new_element[:id] = (@all.max{|index| index.id}) += 1
  #   @all << new_element
  # end

  def update(id, attributes)
    updated_hash = attributes
    find_by_id(id).merge(updated_hash)
  end

  def delete(id)
    @all.delete(find_by_id(id))
  end
end
