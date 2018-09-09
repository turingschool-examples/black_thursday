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
  
end