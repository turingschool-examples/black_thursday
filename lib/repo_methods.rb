module RepoMethods
  def new_id
    @collection.keys.map do |key|
      key
    end.max + 1
  end

  def update(current_id, new_attributes)
    if @collection[current_id] == nil
    else
      @collection[current_id].updated_at = Date.today.strftime("%Y-%m-%e")
      @collection[current_id].update_name(new_attributes)
    end
  end

  def delete(id)
    @collection.delete(id)
  end

  def find_by_id(id)
    @collection[id]
  end

  def find_by_name(name)
    all.detect do |element|
      element.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name_fragment)
    matches = []
    all.each do |element|
      if element.name.downcase.include?(name_fragment.downcase)
        matches << element
      end
    end
    return matches
  end

  def find_all_with_description(description)
    matches = []
    all.each do |element|
      if element.description.downcase.include?(description.downcase)
        matches << element
      end
    end
    return matches
  end

  def all
    @collection.values
  end

  def inspect
    all
  end
end
