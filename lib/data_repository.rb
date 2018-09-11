class DataRepository
  # TODO: Create tests for these

  def initialize(data, data_class)
    @data_class = data_class
    populate(data)
  end

  def inspect
     "#<#{self.class} #{@all.size} rows>"
  end

  def populate(data)
    @data_set = data.inject({}) do |hash, attributes|
      # TODO: Validate each set of "attributes", only add if valid
      attributes[:id] = attributes[:id].to_i
      hash[attributes[:id]] = @data_class.from_raw_hash(attributes)
      hash
    end
  end

  def all
    @data_set.values
  end

  def find_by_id(id)
    @data_set[id]
  end

  def find_by_name(name)
    @data_set.values.find do |entry|
      entry.name.downcase == name.downcase
    end
  end

  def create(attributes)
    attributes[:id] = attributes[:id].to_i
    return nil if @data_set[attributes[:id]]
    @data_set[attributes[:id]] = @data_class.from_raw_hash(attributes)
  end

  # Determine if the attribute hash matches the expected attributes for the
  # data repository's given data_class
  def valid_attributes?(attributes)
  end

  def update(id, attributes)
    @data_set[id].update(attributes)
  end

  def delete(id)
    @data_set.delete(id)
  end
end
