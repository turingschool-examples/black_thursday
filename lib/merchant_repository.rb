require_relative 'merchant.rb'
require 'pry'

class MerchantRepository
  attr_reader :merchants, :repository
  def initialize(merchants)
    @merchants = merchants
    @repository = make_repository
  end

  def make_repository
    @merchants.map do |merchant|
      merchant = Merchant.new(merchant)
    end
  end

  def all
    @repository
  end

  def find_by_id(id)
    @repository.find { |merchant| merchant.id == id }
  end

  def find_by_name(name)
    @repository.find { |merchant| merchant.name.downcase == name.downcase }
  end

  def find_all_by_name(name)
    @repository.select do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def create(attributes)
    max_id = @repository.sort_by{ |merchant| merchant.id }.last.id
    new_id = max_id + 1
    new_merchant = Merchant.new({
                    id: new_id.to_s,
                    name: attributes[:name],
                    created_at: Time.now,
                    updated_at: Time.now
                    })
    @repository << new_merchant
    new_merchant
  end

  def update(id, attributes)
    new_name = attributes[:name]
    merchant = find_by_id(id)
    if !merchant.nil?
      merchant.updated_at = Time.now
      merchant.name = new_name
      merchant
    end
  end

  def delete(id)
    merchant = find_by_id(id)
    @repository.delete(merchant)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end
