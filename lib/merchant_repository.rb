require_relative 'sales_engine'
require_relative 'merchant'

class MerchantRepository
  # Responsible for holding and searching our Merchant instances.
  attr_reader :merchants

  def initialize(merchants)
    @merchants = merchants
    @merchant_repository = []
    create_all_merchants
  end

  def create_all_merchants
    @merchants.each do |merchant|
      @merchant_repository << Merchant.new(merchant)
    end
  end

  def all
    @merchant_repository
  end

  def find_by_id(id)
    @merchant_repository.find do |merchant|
      id == merchant.id
    end
  end

  def find_by_name(name)
    @merchant_repository.find do |merchant|
      name == merchant.name
    end
  end

  def find_all_by_name(name)
    @merchant_repository.find_all do |merchant|
      merchant.name.include?(name)
    end
  end

  def create(attributes)
    highest_id = @merchant_repository.max_by { |merchant| (merchant.id).to_i }
    attributes[:id] = (((highest_id.id).to_i) + 1).to_s
    @merchant_repository << Merchant.new(attributes)
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    merchant.name = attributes[:name]
    merchant
  end

  def delete(id)
    merchant = find_by_id(id)
    @merchant_repository.delete(merchant)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
