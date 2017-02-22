require "csv"
require './lib/merchant'
require 'pry'

class MerchantRepository
  attr_reader :path

  def initialize(csv_path)
    @path = csv_path
    @all = []
  end

  def create_csv_hash
    line = CSV.open path, headers: true, header_converters: :symbol
    csv_hash = line.to_a.map do |row|
      row.to_hash
    end
    csv_hash
  end

  def all(csv_hash)
      @all = csv_hash
  end

  def find_all_by_name(name_fragment)
    @all.select do |merchant|
      merchant.name.downcase.include? (name_fragment.downcase)
    end
  end

  #
  # def create_merchants
  #   i = Merchant.new(self, hash)
  # end

end
