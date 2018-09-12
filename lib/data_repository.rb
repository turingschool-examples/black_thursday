class DataRepository

  def initialize(data, data_class)
    @data_class = data_class
    populate(data)
  end

  def inspect
     "#<#{self.class} #{all.size} rows>"
  end

  def populate(data)
    @data_set = data.inject({}) do |hash, attributes|
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

    new_id = @data_set.keys.max + 1
    attributes[:id] = new_id
    @data_set[new_id] = @data_class.from_raw_hash(attributes)
  end

  def update(id, attributes)
    @data_set[id].update(attributes) if @data_set[id]
  end

  def delete(id)
    @data_set.delete(id)
  end
end
