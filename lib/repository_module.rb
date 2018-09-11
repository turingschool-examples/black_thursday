require 'csv'

module RepoMethods

  def split(filepath)
    objects = CSV.open(filepath, headers: true, header_converters: :symbol)
    attributes_array = []
    objects.map do |object|
      object[:id] = object[:id].to_i
      attributes_array << object.to_h
    end
    attributes_array.each do |hash|
      create(hash)
    end
  end

  def add_individual_item(object)
    @all << object
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
      object_name = object.name.downcase
      object_name.include?(name.downcase)
    end
  end

  def update(id, attributes)
    object = find_by_id(id)
    object.name = attributes[:name]
    if defined? object.description != nil
      object.description = attributes[:description]
    end
    if defined? object.unit_price != nil
      object.unit_price = attributes[:unit_price]
    end
    if defined? object.updated_at != nil
      object.updated_at = Time.now
    end
  end

  def delete(id)
    object = find_by_id(id)
    @all.delete(object)
  end

end
