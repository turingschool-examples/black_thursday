require './lib/merchant'
class MerchantRepository
  attr_reader :list_of_merchants

  def initialize(merchants_data)
    @list_of_merchants = []
    populate_merchants(merchants_data)
  end

  def populate_merchants(merchants_data)
    merchants_data.each do |datum|
      @list_of_merchants << Merchant.new(datum)
    end
  end

  def all
    list_of_merchants

  end


end
