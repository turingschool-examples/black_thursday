# require_relative 'black_thursday_helper'
require 'CSV'
require 'pry'
require './lib/merchant'
require './lib/black_thursday_helper'

class MerchantRepo

include BlackThursdayHelper
  def initialize(file_path)
    @collections = []
    # binding.pry
    populate(file_path)
  end

  # def all
  #   @collections
  # end

  def populate(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @collections << Merchant.new(data)
    end
  end

  def create(merchant_params)
    merchant = Merchant.new(merchant_params)
    highest_current = object_id_counter.id
    new_highest_current = highest_current += 1
    merchant.id = new_highest_current
    @collections << merchant
    merchant
  end

  # def merch_id_counter
  #  @collections.max do |merchant|
  #    merchant.id
  #  end
  # end

  # => dont delete this
  # def update(id, attributes)
  #     if find_by_id(id) != nil
  #     merchant_to_be_updated = find_by_id(id)
  #     merchant_to_be_updated.name = attributes
  #     else
  #       nil
  #     end
  # end
  #
  # def delete(id)
  #   @collections.delete_if do |merchant|
  #     merchant.id == id
  #   end
  # end

end
