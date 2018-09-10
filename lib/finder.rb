require 'pry'

module Finder
  
  def find_by_id(id)
    @csv.keep_if do |key, value|      
      key == id
    end
  end

  def find_by_name(name)
    all.keep_if do |entry|      
      entry.name == name
    end
  end

  def find_all_by_name(name)
    all.keep_if do |entry|      
      entry.name == name
    end
  end

  def find_highest_id
    all.max_by do |entry|
      entry.id
    end
  end

  def create(attributes)
    new_id = find_highest_id.id + 1
    new_item_attributes = {
      :id           => new_id,
      :name         => attributes[:name],
      :description  => attributes[:description],
      :unit_price   => attributes[:unit_price],
      :created_at   => Time.now,
      :updated_at   => Time.now,
      :merchant_id  => 2
    }
    return Item.new(new_item_attributes)
    # next, write to csv
  end

  def delete(id)
    find_by_id(id)
    binding.pry
    #return @all with chosen entry deleted
  end
end