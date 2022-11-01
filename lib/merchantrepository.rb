require_relative 'reposable'
require './lib/merchant.rb'

class MerchantRepository
  include Reposable

  attr_accessor :all

  def initialize(all = [])
    @all = all
  end

  def find_by_name(merchant_name)
    all.find do |merchant|
      merchant.name.upcase == merchant_name.upcase
    end
  end

  def find_all_by_name(merchant_name)
    all.find_all do |merchant|
      merchant.name.upcase.include?(merchant_name.upcase)
    end
  end

  def next_id
    if all.empty?
      1
    else
      all.last.id += 1
    end
  end
end