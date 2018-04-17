# frozen_string_literal: true
require_relative './repository'
require_relative './merchant'
# holds, and provides methods for finding, merchants
class MerchantRepository
  include Repository
  def initialize(merchants)
    create_repository(merchants, Merchant)
  end
  
  def create(attributes)
    general_create(attributes, Merchant)
  end
end
