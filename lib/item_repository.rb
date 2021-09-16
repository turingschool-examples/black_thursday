require 'csv'
require_relative './sales_engine'

class ItemRepository

  def initialize(path)
    @items = to_hash(path)
  end

  def to_hash(path)
    repo = {}
    CSV.foreach(path, headers: true, header_converters: :symbol, :quote_char => '"', liberal_parsing: true) do |row|
      repo[row[:id]] = row.to_hash
    end
    return repo
  end

  def all
   @items.keys
  end

  def find_by_id(id)
    @items.select do |item|
      item[id]
    end
  end

  def find_by_name(name)

  end

end
