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

  def find_all_with_description(input)
    @all.select {|item| item.name.downcase.include?(input.downcase.strip)}
  end

  def find_all_by_price(input)
    @all.select {|item| item.unit_price_to_dollars == input.to_f}
  end

  def find_all_by_price_in_range(low_end,high_end)
    @all.select {|item| item.unit_price_to_dollars >= low_end.to_f && item.unit_price_to_dollars <= high_end.to_f}
  end

end
