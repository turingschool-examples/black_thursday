class Repository

  def all
    @collection.values
  end

  def find_by_id(id)
    @collection[id]
  end

  def find_by_name(name)
    @collection.values.find do |collection|
      collection.name.downcase == name.downcase
    end
  end

  def find_new_id
    max_id_object = @collection.values.max_by do |collection|
      collection.id
    end
    max_id_object.id + 1
  end

  # def delete(id)
  #   find_by_id.each
  # end

  def update(id, attributes)
    thing_to_update = find_by_id(id)
    thing_to_update.name = attributes[:name] if update_name?(attributes)
    thing_to_update.description = attributes[:description] if update_description?(attributes)
    thing_to_update.unit_price = attributes[:unit_price] if update_unit_price?(attributes)
  end

  def update_name?(attributes)
    attributes.has_key?(:name)
  end

  def update_description?(attributes)
    attributes.has_key?(:description)
  end

  def update_unit_price?(attributes)
    attributes.has_key?(:unit_price)
  end

end
