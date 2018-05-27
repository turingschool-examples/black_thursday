module RepoMethods
  def get_data_from_csv(data_from_csv)
    data_from_csv.map do |line|
      [line[:id].to_i, Merchant.new(line)]
    end.to_h
  end

  def create(attributes)
    attributes[:id] = new_id
    @collection[new_id] = Merchant.new(attributes)
  end

  def new_id
    @collection.keys.map do |key|
      key
    end.max + 1
  end

  def update(current_id, new_attributes)
    @collection[current_id].updated_at = Date.today.strftime("%Y-%m-%e")
    @collection[current_id].update_name(new_attributes)
  end

  def delete(id)
    @collection.delete(id)
  end

  def find_by_id(id)
    @collection[id]
  end

  def find_by_name(name)
    all.detect do |element|
      element.name == name
    end
  end

  def find_all_by_name(name_fragment)
    matches = []
    all.each do |element|
      if element.name.include?(name_fragment)
        matches << element
      end
    end
    return matches
  end

  def all
    @collection.values
  end
end
