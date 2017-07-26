require_relative 'item'
require 'csv'
class ItemRepository
  attr_reader :repository

  def initialize(data)
    @repository = {}
    load_csv_file(data)
  end

  def load_csv_file(data)
    CSV.foreach(data, :headers => true, :header_converters => :symbol, :converters => :all) do |row|
      data = row.to_h
      repository[data[:id].to_i] = Item.new(data)
    end
  end

  def all
    repository.values
  end

  def find_by_id(id)
    if repository.keys.include?(id)
      return repository[id]
    end
  end

  def find_by_name(name)
    items = repository.values
    items.each do |item|
      if item.name.downcase == name.downcase
        return item
      end
    end
  end

  def find_all_with_description(description)
    descriptions = []
    items = repository.values
    items.each do |item|
      if item.description.include?(description)
        descriptions << item
      end
    end
    return descriptions
  end

end
