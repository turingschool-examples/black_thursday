# frozen_string_literal: false

require_relative 'merchant'
require_relative 'repository'
# Responsible for holding and searching Merchant instances.
class MerchantRepository
  include Repository
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

  def create(attributes)
    attributes[:id] = find_highest_id.id + 1
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    @repository << Merchant.new(attributes)
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    unless merchant.nil?
      merchant.name        = attributes[:name] if attributes[:name]
      merchant.updated_at  = Time.now
    end
    return nil
  end
end
