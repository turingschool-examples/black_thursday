module Crud

  def load(filepath)
      csv_objects = CSV.open(filepath, headers: true, header_converters: :symbol)
      csv_objects.map do |object|
        object[:id] = object[:id].to_i
        @collection << object.to_h
      end
  end

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

  def delete(id)
    collection.delete_if { |element| element[:id] == id }
  end

end
