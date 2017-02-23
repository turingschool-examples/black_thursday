require "csv"
require './lib/merchant'
require 'pry'

class MerchantRepository
  attr_reader :path, :csv_hash

  def initialize(csv_path)
    @path = csv_path
    @csv_hash = []
  end

  def create_csv_hash
    line = CSV.open path, headers: true, header_converters: :symbol
    line.each { |row| csv_hash << row.to_hash }
  end

  def all
      self.csv_hash
  end

  def find_by_id(merchant_id)
    csv_hash.find { |row| row[:id] == merchant_id.to_s }
  end

  def find_by_name (merchant_name)
    csv_hash.find { |row| row[:name] == merchant_name.to_s}
  end

  def find_all_by_name (merchant_name)
    csv_hash.select { |row| row[:name] == merchant_name.to_s}
  end


end

#binding.pry
""
