class Repository

  def all
    @collection
  end

  def find_by_id(id)
    @collection.find do |collection|
      collection.id == id
    end
  end

  def find_by_name(name)
    @collection.find do |collection|
      collection.name == name
    end
  end

  def find_new_id
    max_id_object = @collection.max_by do |collection|
      collection.id
    end
    max_id_object.id + 1
  end

  # update(id, attributes) - Justin
  # delete(id) - Maddie

end
