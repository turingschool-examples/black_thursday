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
  end
end 

# mr = MerchantRepository.new("./data/merchants.csv")
# mr.create_all_from_csv("./data/merchants.csv")
# p mr.all[1]
# p mr.all.count 
# puts mr.merchants 

