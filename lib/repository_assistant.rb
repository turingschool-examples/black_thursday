module RepositoryAssistant

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

  def create_new_id_number
    max_id = @repository.max_by(&:id).id
    new_id = max_id + 1
  end

  def update(id, attributes)
    repo_object = find_by_id(id)
    return if repo_object.nil?
    repo_object.name = attributes[:name] unless attributes[:name].nil?
    repo_object.description = attributes[:description] unless attributes[:description].nil?
    repo_object.unit_price = attributes[:unit_price] unless attributes[:unit_price].nil?
    repo_object.status = attributes[:status] unless attributes[:status].nil?
    repo_object.updated_at = Time.now
  end
end
