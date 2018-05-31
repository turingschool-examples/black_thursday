require_relative 'merchant'
require_relative 'repository'

class MerchantRepository
  include Repository
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

  def create(attributes)
    highest_id = @repository.max_by { |merchant| merchant.id }
    attributes[:id] = highest_id.id + 1
    @repository << Merchant.new(attributes)
  end
end
