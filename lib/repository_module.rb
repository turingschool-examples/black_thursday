module RepositoryModule

  def all
    @repository.find_all do |repo_object|
      repo_object
    end
  end

  def find_by_name(name)
    @repository.find do |repo_object|
      repo_object.name.downcase == name.downcase
    end
  end

  def find_by_id(id)
    @repository.find do |repo_object|
      repo_object.id == id
    end
  end

  def delete(id)
    found_id = find_by_id(id)
    @repository.delete(found_id)
  end
end
