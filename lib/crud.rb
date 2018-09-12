require 'bigdecimal'
require 'bigdecimal/util'

module Crud

  def load(filepath)
      csv_objects = CSV.read(filepath, headers: true, header_converters: :symbol)
  end

  def find_by_id(id)
    require "pry"; binding.pry
    @collection.find do |element|
      element.data[:id] == id
    end
  end

  def find_by_name(name)
    collection.find do |element|
      element.data[:name].downcase == name.downcase
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def find_all_by_exact(key, string)
    collection.keep_if do |element|
      element.data[key] == string
    end
  end

  def find_all_by(key, string)
    collection.keep_if do |element|
      element.data[key].downcase.include? string.downcase
    end
  end

  def delete(id)
    collection.delete_if { |element| element.data[:id] == id }
  end

  def update(id, key_value_array)
    it = collection.find { |element| element.data[:id] == id}

    key_value_array.map do |key_value|
      if @changeable_attributes.include?(key_value[0])
       it.data[key_value[0]] = key_value[1]
       it.data[:updated_at] = Time.now
      end
    end
  end

end
