require_relative 'merchant'
require 'pry'

class MerchantRepository
  attr_reader :merchant_repo

  def initialize(csv_file)
    @merchant_repo = csv_file.map do |merchant|
      Merchant.new(merchant)
    end
  end

  def all
    @merchant_repo
  end

  def find_by_id(id)
    @merchant_repo.find do |merchant|
      id == merchant.id
    end
  end

  def find_by_name(name)
    @merchant_repo.find do |merchant|
      name == merchant.name 
    end
  end




end
