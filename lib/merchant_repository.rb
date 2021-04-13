
class MerchantRepository

  def initialize(parsed_csv)
    @merchants = parsed_csv

    # turn parsed data into Ruby objects
  end
  def create_merchants(parsed_data)
     test = parsed_data.map do |merchant|
      Merchant.new(merchant)
    end
     require 'pry'; binding.pry
  end

end
