# require_relative 'black_thursday_helper'
require 'CSV'
require 'pry'
require_relative '../lib/merchant'
require_relative '../lib/black_thursday_helper'

class MerchantRepo
include BlackThursdayHelper

  def initialize(file_path)
    @collections = []
    populate(file_path)
  end

  def update(id, attributes)
      if find_by_id(id) != nil
      object_to_be_updated = find_by_id(id)
      object_to_be_updated.name = attributes[:name]
      else
        nil
      end
  end

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
end
