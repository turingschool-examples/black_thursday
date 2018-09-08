module Crud

  def all
    collection
  end

  def find_by_id(id)
    collection.find do |element|
      element[:id] == id
    end
  end

  def find_by_name(name)
    collection.find do |element|
      element[:name] == name
    end
  end

  def find_all_by_name(name)
    name_fixed = name[0..4].downcase
    collection.keep_if do |element|
      element[:name].downcase.include? name_fixed
    end

  end

  def create(attributes)
  end

  def update(id, attributes)
  end

  def delete(id)
  end

end
