require 'csv'
require_relative 'item'

# This class is a repo for items
class ItemRepository
  attr_reader :elements # can be in module

  def initialize
    @elements = {}
  end

  def from_csv(csv) # module
    records = CSV.read(csv, headers: true)
    elements = (0..(records.count - 1)).to_a.map do |index|
      set_element_hash(records, index)
    end
    build_elements_hash(elements)
  end

  def set_element_hash(records, index)
    records[index].to_a.map do |row|
      [row[0].to_sym, row[1]]
    end.to_h
  end

  def build_elements_hash(elements) # need this method in each repo class
    elements.each do |element|
      item = Item.new(element)
      @elements[item.id] = item # unless (item.id.class != Fixnum)
    end
  end

  def all
    @elements.values
  end

  def find_by_id(id_number)
    @elements[id_number]
  end
end
