require 'csv'

require './lib/merchant.rb'
class MerchantRepository 
  
  attr_reader     :filepath,
                  :all 
  def initialize(filepath)
    @filepath = filepath
    @all = []
  end 
  
  def create_all_from_csv(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
      @all << Merchant.new(row)
    end 
  end

  def find_by_id(id)
    @all.find do |object|
      object.id == id 
    end 
  end
  
  def find_by_name(name)
    @all.find do |object|
      object.name.downcase == name.downcase 
    end 
  end 
  
  def find_all_by_name(name)
    #find_all_by_name(name) - returns either [] or one or more matches which contain the supplied name fragment, case insensitive
    @all.find_all do |object| 
      object.name.downcase.include?(name.downcase)
    end 
  end 

  def all
    @merchants
  end
end
