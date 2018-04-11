require 'csv'
require_relative 'merchant'
require 'pry'

class MerchantRepository
  attr_reader :merchants

  def initialize
    @merchants = []
  end

  def all
    @merchants
  end

  def find_by_id(id)
    merchants.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    merchants.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
   found = merchants.map do |merchant|
     if merchant.name.downcase.include?(name.downcase)
       merchant
     end
   end
   found.compact
 end

  def find_highest_id
    merchants.map { |merchant| merchant.id }.max
  end

  def create_new_id
    find_highest_id + 1
  end

  def create(attributes)
    attributes[:id] = create_new_id
    merchants << Merchant.new(attributes)
  end

  def update(id, attributes)
    return nil if find_by_id(id).nil?
    found = find_by_id(id)
    found.change_name(attributes[:name])
    found.change_updated_at
  end

  def delete(id)
    merchants.delete_if do |merchant|
      merchant.id == id
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
