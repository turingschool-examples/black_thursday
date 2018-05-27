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
    merchant = find_by_id(current_id)
    merchant.update_name(new_attributes)
  end

  def delete(id)
    merchant = find_by_id(id)
    @collection.delete(merchant)
  end

  def find_by_id(id)
    @collection[id]
  end

  def find_by_name(name)
    @collection.detect do |merchant|
      merchant.name == name
    end
  end

  def find_all_by_name(name_fragment)
    matches = []
    @collection.each do |merchant|
      if merchant.name.include?(name_fragment)
        matches << merchant
      end
    end
    return matches
  end

  def all
    @collection.values
  end
end
