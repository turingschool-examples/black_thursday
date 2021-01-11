module Repository
  def all
    @collection
  end

  def find_by_id(id)
    @collection.find do |element|
      element.id.to_i == id
    end
  end

  def find_by_name(name)
    @collection.find do |element|
      element.name.downcase == name.downcase
    end
  end

  def highest_id_plus_one
    highest = @collection.max do |element|
      element.id
    end
    highest.id + 1
  end

  def delete(id)
    delete = find_by_id(id)
    @collection.delete(delete)
  end

  def inspect
  "#<#{self.class} #{@collection.size} rows>"
  end
end
