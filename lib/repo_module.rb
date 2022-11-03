module RepoModule

  def find_by_id(id)
    all.find { |obj| obj.id == id}
  end

  def find_by_name(name)
    all.find { |obj| obj.name.upcase == name.upcase}
  end

  def all_ids
    ids = all.map { |obj| obj.id}
  end

  def delete(id)
    all.delete(find_by_id(id))
  end
end
