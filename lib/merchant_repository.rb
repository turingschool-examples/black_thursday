# frozen_string_literal: true

require_relative 'merchant'
require_relative 'repository'
# ./lib/merchant_repository
class MerchantRepository
  include Repository
  attr_reader :merchants
  def initialize
    @merchants = []
  end

  def all
    @merchants
  end

  def inspect
    "#<#{self.class} #{all.size} rows>"
  end

  def find_all_by_name(name)
    @merchants.find_all do |merchant|
      merchant_name = merchant.name.downcase
      merchant_name.include?(name.downcase)
    end
  end

  def create_with_id(attributes)
    @merchants << Merchant.new(attributes)
  end

  def child_class
    Merchant
  end

  def create(attributes)
    all << child_class.create(attributes)
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    merchant.name = attributes[:name] unless merchant.nil?
  end

end
