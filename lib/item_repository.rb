require 'csv'

class ItemRepository
  attr_reader :data_file,
              :items
  
  def initialize(data_file)
    @items = nil
  end


end
