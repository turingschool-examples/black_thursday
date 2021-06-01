require 'CSV'

class MerchantRepository

  def initialize(path)
    @all_merchants = create_merchants(path)
  end

  def create_merchants(path)
  @merchants = CSV.foreach(merchants, headers: true, header_converters: :symbol).map do |merchant|
    Merchant.new(merchant, self)
    end
  end 

  def find_by_id(id)
    @merchant_instances.select do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @merchant_instances.select do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    @merchant_instances.select do |merchant|
      if merchant.name.downcase.include?name.downcase.nil?
        []
      else
        merchant.name.downcase.include?name.downcase
      end
    end
  end

  def
  end

end
