require 'pry'

module Finder
  
  def find_by_id(id)
    @all.detect do |entry|      
      # binding.pry
      entry.id.to_s == id
    end
  end

  def find_by_name(name)
    @all.keep_if do |entry|      
      entry.name == name
    end
  end

  def find_all_by_name(name)
    @all.keep_if do |entry|      
      entry.name == name
    end
  end

  def find_by_highest_id
    @all.max_by do |entry|
      entry.id
    end
  end
  

end