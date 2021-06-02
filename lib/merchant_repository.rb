require_relative 'CSV'
require_relative '../lib/merchant'

class MerchantRepository
  attr_reader :all_merchants

  def initialize(path)
    @all_merchants = create_merchants(path)
  end

  def create_merchants(path)
  merchants = CSV.foreach(path, headers: true, header_converters: :symbol).map do |merchant|
    Merchant.new(merchant, self)
    end
  end

  def find_by_id(id)
    @all_merchants.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @all_merchants.find do |merchant|
      merchant.name.upcase == name.upcase
    end
  end

  def find_all_by_name(name)
    @all_merchants.select do |merchant|
        merchant.name.downcase.include?name.downcase
    end
  end

  def next_highest_merchant_id
    @all_merchants.max_by do |merchant|
      merchant.id
    end.id + 1
  end

  def create(attributes)
    new_merchant = Merchant.new({id: next_highest_merchant_id,
                                 name: attributes})
    @all_merchants << new_merchant
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    merchant[:name] = attributes[:name]
  end

  def delete(id)
    @all_merchants.delete(find_by_id(id))
  end

end
