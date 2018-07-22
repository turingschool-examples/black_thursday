require 'csv'

class MerchantRepo
  attr_reader :merchants

  def initialize
    @merchants = []
  end

  def load_file(file_location)
    mer_repo = MerchantRepo.new
    CSV.foreach(file_location, headers: true, header_converters: :symbol) do |line|
      add_merchant(line.to_h)
    end
    @merchants
  end
    
  def add_merchant(merchant)
    @merchants << Merchant.new(merchant)
  end
  
end

