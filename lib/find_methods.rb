module FindMethods
  def inspect
  end

  def all
    @collection
  end

  def find_by_id(id)
    @collection.find do |element|
      element.id == id
    end
  end

  def find_by_name(name)
    name_case = name.downcase
    @collection.find do |element|
      element.name.downcase.include?(name_case)
    end
  end

  def find_all_by_name(name)
    name_case = name.downcase
    @collection.find_all do |element|
      element.name.downcase.include?(name_case)
    end
  end
  
  def delete(id)
    @collection.delete_if do |collection|
      collection.id == id
    end
  end

end
