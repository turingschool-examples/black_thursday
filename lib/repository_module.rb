module RepoMethods

  def split(filepath)
    objects = CSV.open(filepath, headers: true, header_converters: :symbol)

    objects.map do |object|
      object[:id] = object[:id].to_i

      @attributes_array << object.to_h
    end
    @attributes_array.each do |hash|
      create(hash)
    end
  end

  def all
    @all
  end

  def find_by_id(id)
    @all.find do |object|
      object.id == id
    end
  end

  def find_by_name(name)
    @all.find do |object|
      object.name.downcase == name.downcase
    end
  end

  def update(id, attributes)
    object = find_by_id(id)
    object.name = attributes[:name]
    object.description = attributes[:description]
    object.unit_price = attributes[:unit_price]
    object.updated_at = Time.now
  end

  def delete(id)
    object = find_by_id(id)
    @all.delete(object)
  end

end
