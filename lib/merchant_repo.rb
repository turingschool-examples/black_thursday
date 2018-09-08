# require_relative 'black_thursday_helper'
require 'CSV'
require 'pry'
require './lib/merchant'

class MerchantRepo
  #how do we indent this?
  # include Black_Thursday_Helper

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


end
