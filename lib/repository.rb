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

  def delete(id)
    @collection.delete(id)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end
