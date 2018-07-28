# frozen_string_literal: true

require_relative './merchant'
require_relative './repository_helper'

# Merchant repository class
class MerchantRepository
  include RepositoryHelper

  def initialize
    @merchants = {}
  end

  def create(params)
    params[:id] = @merchants.max[0] + 1 if params[:id].nil?

    Merchant.new(params).tap do |merchant|
      @merchants[params[:id].to_i] = merchant
    end
  end

  def update(id, params)
    return nil unless @merchants.key?(id)
    new_name = params[:name]
    merchant = find_by_id(id)
    merchant.name = new_name
    merchant
  end

  def all
    merchant_pairs = @merchants.to_a.flatten
    remove_keys(merchant_pairs, Merchant)
  end

  def find_by_id(id)
    return nil unless @merchants.key?(id)
    @merchants.fetch(id)
  end

  def find_by_name(name)
    all.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    merchant_pairs = @merchants.find_all do |_, merchant|
      merchant.name.downcase.include?(name.downcase)
    end.flatten
    remove_keys(merchant_pairs, Merchant)
  end

  def delete(id)
    @merchants.delete(id)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
