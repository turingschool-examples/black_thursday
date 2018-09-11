require_relative './repository_module'
require 'pry'

class ItemRepository
  include RepoMethods

  def initialize(filepath = nil)
    @filepath = filepath
    @all = []
    split(filepath) if filepath != nil
  end

  def create(attributes)
    isnt_included = @all.any? do |item|
      attributes[:id] != item.id
    end
    has_id = attributes[:id] != nil
    if has_id && isnt_included
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

  def find_all_with_description(description)
    @all.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

]
  def find_all_by_price(price)
    @all.find_all do |item|
      item.unit_price.to_f == price.to_f
    end
  end

  def find_all_by_price_in_range(range)
    @all.find_all do |item|
      range.include?(item.unit_price.to_f)
    end
  end


  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |item|
      item.merchant_id == merchant_id.to_i
    end
  end

end
