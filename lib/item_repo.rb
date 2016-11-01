require './lib/item'
require './lib/data_parser'
require 'pry'

class ItemRepo
  include DataParser
  attr_reader :all

  def initialize
    @all = parse_data('./data/items.csv').map { |row| Item.new(row) }
  end

  def find_by_id(id)
    @all.find(id) {|item| item.id.eql?(id)}
  end

  def find_by_name(name)
    @all.find(name) {|item| item.name.downcase.eql?(name.downcase)}
  end

  def find_all_with_description(description_fragment)
    @all.find_all {|item| item.description.downcase.include?(description_fragment)}
  end
end
