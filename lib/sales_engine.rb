require 'csv'

class SalesEngine
  attr_reader :mr

  def self.from_csv(data)
    @mr = MerchantRepository.new
    CSV.foreach(data[:merchants], headers: true, header_converters: :symbol) do |row|
      merchant = Merchant.new({id: row[:id].to_i, name: row[:name]})
      @mr.add_merchant_to_repo(merchant)
    end
    require "pry"; binding.pry
    @mr
  end

  def self.merchants
    @mr
  end
end
