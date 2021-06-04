require './merchant'
require 'CSV'

class MerchantRepository
  attr_reader :all,
              :path

  def initialize(path)
    @path = path
    @all = create_merchants(path)
  end

  def create_merchants(path)
    merchants = CSV.read(path, headers: true, header_converters: :symbol)
    merchants.map do |data|
      Merchant.new(data)
    end
  end

  def find_by_id(id)
    @all.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @all.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    @all.find_all do |merchant|
      merchant.name.downcase.include?(name)
    end 
  end

  def create(attributes)
    highest_id = @all.max_by { |merchant| merchant.id }
    merchant = Merchant.new(attributes)
    merchant.new_id(highest_id.id + 1)
    @all << merchant 
  end

  def update(id, attributes)
    update1 = @all.find do |merchant|
      merchant.id == id
    end
    update1.update_name(attributes)
  end

  def delete(id)
    merchant = @all.find do |merchant|
      merchant.id == id 
    end
    @all.delete(merchant)
  end
end
