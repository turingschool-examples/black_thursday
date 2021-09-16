require 'csv'
require_relative './sales_engine'

class ItemRepository
  attr_reader :items

  def initialize(data)
    @items = data
  end

  # def to_hash(path)
  #   repo = {}
  #   CSV.foreach(path, headers: true, header_converters: :symbol,
  #                     quote_char: '"', liberal_parsing: true) do |row|
  #     repo[row[:id]] = row.to_hash
  #   end
  #   repo
  # end

  def all
    # require "pry"; binding.pry
    @items
  end

  def find_by_id(id)
    @items.select do |item|
      item[id]
    end
  end

  def find_by_name(name)
    return_name = []
    @items.find do |key, value|
      next unless value[:name].downcase == name.downcase

      return_name << { key: value }
      # require 'pry'
      # binding.pry
    end
    return_name
  end
end
