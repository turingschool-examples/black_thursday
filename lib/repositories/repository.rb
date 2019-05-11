# Shared methods for searching repository classes
class Repository
  def initialize(collection, klass)
    @collection = collection
    @klass = klass
  end

  def create_index(data_type, attributes)
    data = {}
    attributes.each do |attribute_set|
      data[attribute_set[:id].to_i] = data_type.new(attribute_set)
    end
    data
  end

  def all
    @collection.values
  end

  def find_by_id(id)
    @collection[id]
  end

  def find_by_name(name)
    @collection.values.find do |thing|
      thing.name.casecmp(name).zero?
    end
  end

  def find_all_by_name(fragment)
    @collection.values.find_all do |thing|
      thing.name.downcase.include?(fragment.downcase)
    end
  end

  def create_new_id
    highest_id = @collection.keys.max
    (highest_id.to_i + 1)
  end

  def create(attributes)
    attributes[:id] = create_new_id
    @collection[attributes[:id]] = @klass.new(attributes)
  end

  def delete(id)
    @collection.delete(id)
  end

  def inspect
    "#<#{self.class} #{@collection.size} rows>"
  end
end
