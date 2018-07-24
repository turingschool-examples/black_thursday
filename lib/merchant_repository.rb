require 'csv'
class MerchantRepository 
  def initialize#(merchants_file)
    @merchants = []
  end 
  
  def create_merchants_from_csv 
    CSV.foreach('./data/merchants.csv', headers: true, header_converters: :symbol) do |row|
      @merchants << Merchant.new(row)
    end 
  end
  
  def all 
    @merchants 
  end 
  
  def find_by_id(id) 
  end
end 

mr = MerchantRepository.new

