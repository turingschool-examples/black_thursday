require 'csv'

class MerchantRepository
  def initialize(file)
    @merchants = []
    merchant_data = CSV.open file, headers: true, header_converters: :symbol, converters: :numeric
    parse(merchant_data)
  end

  def parse(merchant_data)
    merchant_data.each do |row|
      id = row[:id]
      name = row[:name]
      @merchants << Merchant.new({id: id, name: name})
    end
  end

  def all
    return @merchants
  end

  def find_by_id(id)
    @merchants.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @merchants.find do |merchant|
      merchant.name == name
    end
  end

  def find_all_by_name(name)
    @merchants.find_all do |merchant|
      merchant.name == name
    end
  end
end
