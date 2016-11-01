# require './lib/item'
require 'csv'
require 'pry'

class ItemRepository
  def set_up
    @file = CSV.open "./data/items.csv", headers: true, header_converters: :symbol
  end #maybe not needed because files linked

  def all(file)
    all = []
    all << @file
  end

  def find_by_id(id_num)
    @file.detect do |item|
      item_id = item.each do |row|
        row[0]
      end
      binding.pry
      if @file.row[0] == id_num
        binding.pry
        puts item
      end
    end
  end

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

trial = ItemRepository.new
# # file = CSV.open "items.csv", headers: true, header_converters: :symbol
# trial.set_up
# puts trial.all
trial.set_up
puts trial.find_by_id(263398227)
