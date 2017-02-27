require_relative 'item'
require 'pry'
require 'time'
require_relative '../lib/data_access'

class ItemRepository
  include DataAccess
  attr_reader :csv_file, :all, :parent

#make module for initialize, make_items >> populate_repo

  def initialize(path, parent=nil)
    @csv_file = CSV.open(path, headers: true, header_converters: :symbol)
    @all = []
    @parent = parent
    populate_repo
  end

  def populate_repo
    csv_file.each do |row|
      item = Item.new({:id => row[:id].to_i,
        :name => row[:name],
        :description => row[:description],
        :unit_price => transform_price(row[:unit_price]),
        :merchant_id => row[:merchant_id].to_i,
        #make time methods, time.now
      
        :created_at => Time.parse(row[:created_at]),
        :updated_at => Time.parse(row[:updated_at])}, self)
        @all << item

        #return an array, then you can nix @all
      end
  end

  #make a format method?
  
        #make it BigDecimal
        #could make a transform_price method



##############

  # def transform_price(price)
  #   formatted_price = (BigDecimal.new(price.to_i)/100)
  # end


  # def find_by_id(id)
  #   all.find{ |item| item.id == id }
  # end

  # def find_by_name(name)
  #   all.find{ |item| item.name.downcase == name.downcase }
  # end

  # def find_all_with_description(description)
  #   all.select{ |item| item.description.downcase == description.downcase }  
  # end

  # def find_all_by_merchant_id(merchant_id)
  #   all.select{ |item| item.merchant_id == merchant_id }
  # end

  # def find_all_by_price(unit_price)
  #   all.select{ |item| item.unit_price == unit_price }
  # end

  # def find_all_by_price_in_range(range)
  #   all.select{ |item| range.include?(item.unit_price)  }
  # end

  

  # def inspect
  #   "#<#{self.class} #{@items.size} rows>"
  # end

##############


  # def from_csv(input_hash)
  #   # contents = CSV.open "data/items.csv"       #headers: true, header_converters: :symbol
  #   # output = "#{:id},#{:name},#{:description},#{:unit_price},#{:merchant_id},#{:created_at},#{:updated_at}"
  #   @all = ItemRepository.new(item_path)
  #   @merchants = MerchantRepository.new



# find_all_by_price - returns either [] or instances of Item where the supplied price exactly matches
# find_all_by_price_in_range - returns either [] or instances of Item where the supplied price is in the supplied range (a single Ruby range instance is passed in)




end


# binding.pry

""