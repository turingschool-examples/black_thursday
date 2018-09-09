
require 'pry'
module Finder
  
  def all
    # binding.pry
    @csv
  end

  def find_by_id(id)
    @csv.keep_if do |key, value|      
      key == id
    end
  end

  def find_by_name(name)
    @csv.keep_if do |key, value|      
      value[:name] == name
    end
  end

  def find_all_by_name(name)
    @csv.keep_if do |key, value|      
      value[:name] == name
    end
  end

  
end