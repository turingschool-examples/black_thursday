require_relative '../lib/sales_engine'
require_relative '../lib/csv_adaptor'
require "pry"

class MerchantRepo

  include CsvAdaptor

  attr_accessor :merchants,
                :csv_hashes

  def initialize(merchants = [])
    binding.pry
    @merchants = merchants
    #csv_merchants_to_objects
    @csv_hashes = csv_hashes
  end

  def all
    @merchants
  end

  def csv_merchants_to_objects(csv_hashes)
    @csv_hashes.each do |hash|
      require "pry"; binding.pry
      add_merchant_objects(hash)
    end
  @merchants
  end

  def add_merchant_objects(merchant_hash)
    @merchants << Merchant.new(merchant_hash)
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

  def create(attributes)
    merchant_new = Merchant.new(attributes) #refactor with module?
    max_merchant_id = @merchants.max_by do |merchant|
      merchant.id
    end
    new_max_id = max_merchant_id.id + 1
    merchant_new.id = new_max_id
    @merchants << merchant_new
    return merchant_new
  end

  def update(id, attributes)
    merchant_to_change = find_by_id(id)
    merchant_to_change.name = attributes[:name]
  end

  def delete(id)
    merchant_to_delete = find_by_id(id)
    @merchants.delete(merchant_to_delete)
  end

end
