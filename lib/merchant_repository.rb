require_relative '../lib/merchant'
require 'CSV'
require 'pry'

class MerchantRepository

  attr_reader :filename

  def initialize(filename)
    @filename = filename
  end

  def rows
    rows = CSV.read(@filename, headers: true, header_converters: :symbol)
  end

  def all
    result = rows.map {|row| Merchant.new(row)}
  end

  def find_by_id(id)
    result = rows.find_all do |row|
      Merchant.new(row) if row[:id] == id
    end
    !result.empty? ? result : nil 
  end

end
