require './lib/item'
require 'csv'
require 'pry'

class ItemRepo
  
  # def initialize
  #   # @parent = sales_engine
  #   @all = []
  # end

  # def set_up(file)
  #   CSV.read (file), headers: true, header_converters: :symbol
  #   parse_file(file)
  # end 
 
  def all
    @all
  end
  
  def parse_file(file)
    CSV.foreach("./data/items.csv") do |row|
      next if row[0] == "id"
      instantiate_item(row)  
    end
  end

  def instantiate_item(row)
      item = {:id => row[0],
        :name => row[1],
        :description => row[2],
        :unit_price => row[3],
        :merchant_id => row[4],
        :created_at => row[5],
        :updated_at => row[6]
        }
      @all << Item.new(item, self)
  end


  # def find_by_id(id_num)
  #   right_item = []
  #   binding.pry
  #   @file.find do |item|
  #     right_item << item[:id] == id_num
  #     binding.pry
  #     right_item
  #   end
  # end

  def find_by_name
    #search for a name
    #return item with that name, case insensitive
  end

  def find_all_with_description
    #returns instances of item where the supplied string occurs in the description
    #case insensitive
  end

  def find_all_by_price
    #returns objects that match with price provided
  end

  def find_all_by_price_in_range
      #returns objects that match with range price provided
  end

  def find_all_by_merchant_id
    #search merchant with that id
    #returns all items of that merchant
  end
end




