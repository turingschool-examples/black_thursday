require 'helper'

class ItemRepository
  attr_reader :all

  def initialize(file_path)
    # @file_path = file_path
    # @items = all
    @all = CSV.foreach(file_path, headers: true, header_converters: :symbol) {|row| Item.new(row)}
  end

  # def all
  #   CSV.foreach(file_path, headers: true, header_converters: :symbol) {|row| Item.new(row)}
  # end

  def find_by_id(id_number)
    @all.find {|item| item.id == id_number}
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

  def find_all_by_merchant_id(merchant_id)
    @all.select {|item| item.merchant_id == merchant_id}
  end

  def max_item_id
    (@all.max_by {|item| item.id}).id
  end

  def create(name,description,price,merchantID)
    @all << Item.new({
      :id => max_item_id + 1,
      :name => name,
      :description => description,
      :unit_price => price,
      :created_at => Time.now,
      :updated_at => Time.now,
      :merchant_id => merchantID
      })
  end

  def update(id,new_name,new_description,new_price)
    to_be_updated = find_by_id(id)
    to_be_updated.name = new_name
    to_be_updated.description = new_description
    to_be_updated.unit_price = new_price
  end

  def delete(id)
    to_be_dropped = find_by_id(id)
    @all.delete(to_be_dropped)
  end

end
