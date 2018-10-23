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

  def find_max_id
    max_id_object = @collection.max_by do |collection|
      collection.id
    end
    max_id_object.id + 1
  end

#create(attributes) - create a new Item instance with the
# provided attributes. The new Item’s
# id should be the current highest Item id plus 1


  # create(attributes)  <<< Maybe??
  # update(id, attributes)
  # delete(id)

end
