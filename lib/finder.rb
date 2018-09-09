
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

  # def find_entry_by_created(entry_class, attribute)
  #   @csv.keep_if do |key, value|      
  #     value[:created_at] == attribute
  #   end
  # end

  # def find_entry_by_updated(entry_class, attribute)
  #   @csv.keep_if do |key, value|      
  #     value[:updated_at] == attribute
  #   end
  # end

  
end