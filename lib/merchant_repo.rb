# require_relative 'black_thursday_helper'
require 'CSV'
require 'pry'
require './lib/merchant'

class MerchantRepo

  def initialize(file_path)
    @merchants = []
    populate(file_path)
  end

  def all
    @merchants
  end

  def populate(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @merchants << Merchant.new(data)
    end
  end

  def find_by_id(id)
   @merchants.find do |merchant|
     merchant.id == id
   end
  end

  def find_by_name(name)
    @merchants.find do |merchant|
      merchant.name == name
    end
  end

  def find_all_by_name(name)
   @merchants.find_all do |merchant|
     merchant.name.downcase.include? (name.downcase)
   end
  end

  def create(merchant_params)
    merchant = Merchant.new(merchant_params)
    highest_current = merch_id_counter.id
    new_highest_current = highest_current += 1
    merchant.id = new_highest_current
    @merchants << merchant
     merchant
  end

  def merch_id_counter
   @merchants.max do |merchant|
     merchant.id
   end
  end

  def update(id, attributes)
      if find_by_id(id) != nil
      merchant_to_be_updated = find_by_id(id)
      merchant_to_be_updated.name = attributes
      else
        nil
      end
  end

end
