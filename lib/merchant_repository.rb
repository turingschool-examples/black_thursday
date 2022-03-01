# frozen_string_literal: true

# merchant_repository
class MerchantRepository
  attr_reader :merchants

  def initialize(merchants)
    @merchants = merchants
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find { |merchant| merchant.id == id }
  end

  def find_by_name(name)
    @merchants.find { |merchant| merchant.name.downcase == name.downcase }
  end

  def find_all_by_name(fragment)
    @merchants.find_all { |merchant| merchant.name.downcase.include?(fragment) }
  end

  def create(attributes)
    @merchants.sort_by(&:id)
    last_id = @merchants.last.id
    attributes[:id] = (last_id += 1)
    @merchants << Merchant.new(attributes)
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    attributes.map do |key, v|
      # require "pry"; binding.pry
      merchant.name = v if key == :name
    end
  end

  def delete(id)
    @merchants.delete(find_by_id(id))
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
