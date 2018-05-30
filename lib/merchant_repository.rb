# require_relative 'sales_engine'
require_relative 'merchant'
require 'pry'

class MerchantRepository
  # Responsible for holding and searching Merchant instances.
  attr_reader :merchants

  def initialize(merchants)
    @merchants = merchants
    @repository = []
    create_all_merchants
  end

  def create_all_merchants
    @merchants.each do |merchant|
      @repository << Merchant.new(merchant)
    end
  end

  def all
    @repository
  end

  def find_by_id(id)
    @repository.find do |merchant|
      id == merchant.id
    end
  end

  def find_by_name(name)
    @repository.find do |merchant|
      name.downcase == merchant.name.downcase
    end
  end

  def find_all_by_name(name)
    @repository.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def create(attributes)
    highest_id = @repository.max_by do |merchant|
      merchant.id
    end
    attributes[:id] = highest_id.id + 1
    @repository << Merchant.new(attributes)
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    unless merchant.nil?
      merchant.name = attributes[:name]
    end
    return nil
  end

  def delete(id)
    merchant = find_by_id(id)
    @repository.delete(merchant)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
