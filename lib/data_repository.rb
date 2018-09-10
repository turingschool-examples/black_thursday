class DataRepository
  # TODO: Create tests for these

  def initialize(data, data_class)
    @data_class = data_class
    populate(data)
  end

  def populate(data)
    @data_set = data.inject({}) do |hash, attributes|
      # TODO: Validate each set of "attributes", only add if valid
      attributes[:id] = attributes[:id].to_i
      # binding.pry
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

  # create a new Merchant instance with the provided attributes. The new Merchant’s id should be the current highest Merchant id plus 1.
  def create(attributes)
  end

  # Determine if the attribute hash matches the expected attributes for the
  # data repository's given data_class
  def valid_attributes?(attributes)
  end

  # update the Merchant instance with the corresponding id with the provided attributes. Only the merchant’s name attribute can be updated.
  def update(id, attributes)
  end

  # delete the Merchant instance with the corresponding id
  def delete(id)
  end
end
