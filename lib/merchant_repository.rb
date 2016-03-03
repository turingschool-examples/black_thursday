require_relative '../lib/merchant'
require 'csv'
require 'pry'

# contents = CSV.open '../merchants.csv', headers: true, header_converters: :symbol

class MerchantRepository
  attr_accessor :repository

  def initialize
    @repository = []

    # contents.each do |row|
    #   row_from_csv = {:id => row[:id], :name => row[:name]}
    #   m = Merchant.new(row_from_csv)
    #   @merchants.push(m)
    # end
  end

  def all
    @repository
  end

  def find_by_id(number)
    @repository.find do |merchant|
      merchant.id == number
    end
  end

  def find_by_name(name)
    @repository.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name_fragment)
    found = @repository.find_all do |merchant|
      merchant.name.downcase.include?(name_fragment.downcase)
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
