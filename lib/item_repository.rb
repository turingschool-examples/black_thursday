require 'csv'
require 'pry'
require "./lib/item"

class ItemRepository

  attr_reader :all

  def initialize(file_path)
    @file_path = file_path
    @all = []

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Item.new(row)
    end

  end

  def find_by_id(id_number)
    @all.find {|item| item.id == id_number.to_s}
  end

  def find_by_name(name)
    @all.find {|item| item.name.downcase == name.downcase.strip}
  end

end
