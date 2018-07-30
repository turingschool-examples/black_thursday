# frozen_string_literal: true

require_relative './merchant'
require_relative './repository_helper'

# Merchant repository class
class MerchantRepository
  include RepositoryHelper

  def update(id, params)
    return nil unless @repository.key?(id)
    new_name = params[:name]
    merchant = find_by_id(id)
    merchant.name = new_name
    merchant.updated_at = Time.now
    merchant
  end

  def find_all_by_name(name)
    all.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  private

  def sub_class
    Merchant
  end
end
