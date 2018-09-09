
module Finder
  
  def find_entry_by_name(entry_class, attribute)
    values = @csv.values
    search_results = values.keep_if do |value|
      value[:name] == attribute
    end
    search_results
  end


  # returns an array of all objects
  
  def find_all_by(entry_class, attribute)
    # case class
    # 
    # calls find_by to return all chosen
    #
    #
    #
    #
    #
    #    

  end
end