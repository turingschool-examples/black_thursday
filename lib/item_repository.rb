require 'csv'
require 'bigdecimal'
require 'time'
require_relative './repository_module'

class ItemRepository
  include RepoMethods

  def initialize(filepath = nil)
    @filepath = filepath
    @all = []
    split(filepath) if filepath != nil
  end

  def create(attributes)
    is_included = @all.any? do |item|
      attributes[:id] == item.id
    end
    is_included = false if @all == []
    has_id = attributes[:id] != nil
    if has_id && !is_included
      @all << Item.new(attributes)
    elsif @all == []
      new_id = 1
      attributes[:id] = new_id
      @all << Item.new(attributes)
    else
      highest_id = @all.max_by do |item|
        item.id
      end.id
      new_id = highest_id + 1
      attributes[:id] = new_id
      @all << Item.new(attributes)
    end
  end

  def split(filepath)
    objects = CSV.open(filepath, headers: true, header_converters: :symbol)
    attributes_array = []
    objects.map do |object|
      object[:id] = object[:id].to_i

      object[:unit_price] = BigDecimal.new(object[:unit_price]) / 100

      object[:merchant_id] = object[:merchant_id].to_i

      object[:created_at] = Time.parse(object[:created_at])

      object[:updated_at] = Time.parse(object[:updated_at])

      attributes_array << object.to_h
    end
    attributes_array.each do |hash|
      create(hash)
    end
  end

  def find_all_with_description(description)
    @all.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    @all.find_all do |item|
<<<<<<< HEAD
      item.unit_price.to_f == price.to_f
      binding.pry
=======
      item.unit_price_to_dollars == price
>>>>>>> f383e696193518f2683634daad455d6f6829953c
    end
  end

  def find_all_by_price_in_range(range)
    @all.find_all do |item|
      range.include?(item.unit_price_to_dollars)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |item|
      item.merchant_id == merchant_id.to_i
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end
