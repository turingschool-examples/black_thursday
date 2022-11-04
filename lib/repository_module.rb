module RepositoryModule

  def find_by_id(id)
    all.find { |obj| obj.id == id}
  end

end
