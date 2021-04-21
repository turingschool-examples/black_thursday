require 'merchant'
class MerchantRepo
  attr_reader :merchants,
              :engine

  def initialize(path, engine)
    @merchants = []
    @engine = engine
    populate_information(path)
  end

  def populate_information(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |data|
      @merchants << Merchant.new(data, self)
    end
  end

  def all
    @merchants
  end

  def add_merchant(merchant) 
    @merchants << merchant
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

  def find_all_by_name(name_fragment) 
    @merchants.find_all do |merchant|
      merchant.name.downcase.include?(name_fragment.downcase)
    end
  end

  def create(attributes)
    merchant = Merchant.new(attributes, self)
    max = @merchants.max_by do |merchant|
      merchant.id
    end
    merchant.id = max.id + 1
    add_merchant(merchant)
    merchant
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    return if !merchant
    merchant.update_name(attributes)
  end

  def delete(id)
    @merchants.delete(find_by_id(id))
  end
end
