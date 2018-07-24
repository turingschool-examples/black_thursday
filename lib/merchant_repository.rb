# frozen_string_literal: true

require './lib/merchant'

# Merchant repository class
class MerchantRepository
  def initialize
    @merchants = {}
  end

  def populate_from_csv(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
      create(row)
    end
  end

  def create(params)
    Merchant.new(params).tap do |merchant|
      @merchants[params[:id].to_i] = merchant
    end
  end

  def all
    merchant_pairs = @merchants.to_a.flatten
    merchant_pairs.keep_if do |element|
      element.is_a?(Merchant)
    end
  end

  def find_by_id(id)
    @merchants.fetch(id)
  end

  def find_by_name(name)
    @merchants.find do |_, merchant|
      merchant.name.downcase == name.downcase
    end.last
  end

  def find_all_by_name(name)
    merchant_pairs = @merchants.find_all do |_, merchant|
      merchant.name.downcase.include?(name.downcase)
    end.flatten
    merchant_pairs.keep_if do |element|
      element.is_a?(Merchant)
    end
  end

  def update(id, params)
    new_name = params[:name]
    merchant = find_by_id(id)
    merchant.name = new_name
    merchant
  end

  def delete(id)
    @merchants.delete(id)
  end
end
