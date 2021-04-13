require './lib/merchant'
class MerchantRepository
  attr_reader :merchants
  def initialize(parsed_csv)
    @merchants = create_merchants(parsed_csv)
  end

  def create_merchants(parsed_data)
     parsed_data.map do |merchant|
      Merchant.new(merchant)
    end
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @merchants.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    full_names = []
    @merchants.each do |merchant|
      if merchant.name.include?(name)
        full_names.push(merchant)
      end
    end
    full_names
  end
end
