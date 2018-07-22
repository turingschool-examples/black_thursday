class MerchantRepository 
  def initialize(merchants_file)
    @merchants = []
  end 
  
  def create_merchants 
    CSV.foreach('./data/merchants.csv', headers: true, header_converters: :symbol) do |row|
      @merchants << Merchant.new(row)
    end 
  end
  
  def all 
    @merchants 
  end  
end 

