require_relative 'item'
require 'pry'

class ItemRepository
  attr_reader :csv_file, :all

  def initialize(path)
    @csv_file = CSV.open(path, headers: true, header_converters: :symbol)
    @all = []
    make_items
  end

  def make_items
    csv_file.each do |row|
      item = Item.new({:id => row[:id].to_i,
        :name => row[:name],
        :description => row[:description],
        :unit_price => transform_price(row[:unit_price]),
        :merchant_id => row[:merchant_id].to_i,
        #make time methods, time.now
      
        :created_at => row[:created_at],
        :updated_at => row[:updated_at]})
        @all << item

        #return an array, then you can nix @all
      end
  end

  #make a format method?
  
        #make it BigDecimal
        #could make a transform_price method

  def transform_price(price)
    formatted_price = (BigDecimal.new(price.to_i)/100).to_f
  end



  def find_by_id(id)
    all.find{ |item| item.id == id }
  end

  def find_by_name(name)
    all.find{ |item| item.name.downcase == name.downcase }
  end

  def find_by_description(description)
    all.select{ |item| item.description.downcase == description.downcase }  
  end

  def find_all_by_merchant_id(merchant_id)
    all.select{ |item| item.merchant_id == merchant_id }
  end


  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  # def from_csv(input_hash)
  #   # contents = CSV.open "data/items.csv"       #headers: true, header_converters: :symbol
  #   # output = "#{:id},#{:name},#{:description},#{:unit_price},#{:merchant_id},#{:created_at},#{:updated_at}"
  #   @all = ItemRepository.new(item_path)
  #   @merchants = MerchantRepository.new
end
