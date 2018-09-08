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

end
