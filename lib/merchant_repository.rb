require 'csv'
require_relative 'merchant'
require_relative 'inspector'

class MerchantRepository
  include Inspector
  attr_reader :all

  def initialize(file_path)
    @file_path = file_path
    @all = []

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Merchant.new(row)
    end
  end

  def find_by_name(merchant_name_search)
    @all.find do |merchant|
      merchant.name.downcase == merchant_name_search.downcase
    end
  end

  def find_all_by_name(name_fragment_search)
    @all.find_all do |merchant|
      merchant.name.downcase.include?("#{name_fragment_search.downcase}")
    end
  end
end
