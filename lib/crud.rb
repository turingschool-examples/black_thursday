require 'bigdecimal'
require 'bigdecimal/util'

module Crud

  def load(filepath)
      csv_objects = CSV.read(filepath, headers: true, header_converters: :symbol)
  end

  def find_by_id(num)
    @collection.find do |element|
      element.id == num
    end
  end

  def find_by_name(name)
    collection.find do |element|
      (element.name).downcase == name.downcase
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def find_all_by(type, string)
    collection.find_all do |element|
      element.send(type).downcase.include? string.downcase
    end
  end

  def find_all_by_exact(type, input)
    collection.find_all do |element|
      element.send(type) == input
    end
  end

  def find_all_by_exact(type, input)
    collection.find_all do |element|
      element.send(type) == input
    end
  end

  def delete(id)
    collection.delete_if { |element| element.id == id }
  end
end
