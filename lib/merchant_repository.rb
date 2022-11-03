# frozen_string_literal: true

require_relative 'merchant'
require_relative 'general_repo'

# This is the MerchantRepository Class
class MerchantRepository < GeneralRepo
  attr_reader :repository

  def initialize(data, se)
    super('Merchant', data, se)
  end

  def find_by_name(name)
    repository.find { |merchant| merchant.name.casecmp?(name) }
  end

  def find_all_by_name(name)
    repository.select { |merchant| merchant.name.downcase.include? name.downcase }
  end
end
