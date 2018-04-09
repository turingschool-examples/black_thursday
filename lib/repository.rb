# Shared methods for searching repository classes
class Repository
  def initialize(collection)
    @collection = collection
  end

  def create_index(data_type, attributes)
    data = {}
    attributes.each do |attribute_set|
      data[attribute_set[:id]] = data_type.new(attribute_set)
    end
    data
  end

  def all
    @collection.values
  end

  # def find_by_id(id)
  # end
end
