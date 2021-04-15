class Repository
  def initialize(location_hash, engine)
    @location_hash = location_hash
    @engine = engine
  end

  def all
    @csv_array
  end

  def find_by_id(id)
    @csv_array.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @csv_array.find do |item|
      item.name.casecmp?(name)
    end
  end

  def max_id_number_new
    old_max = @csv_array.max_by do |item|
      item.id
    end.id
    (old_max.to_i + 1).to_s
  end

  def delete(id)
    @csv_array.delete(find_by_id(id))
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
