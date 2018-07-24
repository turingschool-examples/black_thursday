module RepositoryModule

  def all
    @repository.find_all do |element|
      element
  end

  def find_by_id(id)
    @repository.find do |element|
      element.id == id
    end
  end

  def delete(id)
    @repository.delete_if {|element| element.id == id}
    end
  end

end
