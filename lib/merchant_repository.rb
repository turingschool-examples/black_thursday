require_relative 'merchant'
require 'pry'

class MerchantRepository
  attr_reader :merchant_repo

  def initialize(csv_file)
    @merchant_repo = csv_file.map do |merchant|
      Merchant.new(merchant)
    end
  end

  def all
    @merchant_repo
  end

  def find_by_id(id)
    @merchant_repo.find do |merchant|
      id == merchant.id
    end
  end

  def find_by_name(name)
    @merchant_repo.find do |merchant|
      name.downcase == merchant.name.downcase
    end
  end

  def find_all_by_name(name)
    all_names = @merchant_repo.select do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
    return all_names
  end

  def create(attributes)
    max_id = @merchant_repo.max_by do |merchant|
      merchant.id
    end # this returns the complete merchant object with highest id
    new_id = max_id.id + 1
    new_merchant = Merchant.new(
      id: new_id,    #check for .to_s later
      name: attributes[:name],
      created_at: Time.now,
      updated_at: Time.now
    )
    @merchant_repo << new_merchant
    new_merchant
  end

  def update(id, attributes)
    new_name = attributes[:name]
    merchant = find_by_id(id)
    return if merchant.nil?
    merchant.updated_at = Time.now
    merchant.name = new_name
    merchant
  end

  def delete(id)
    object = find_by_id(id)
    @merchant_repo.delete(object)
  end

end
