require_relative '../lib/merchant'
require 'CSV'
require 'pry'

class MerchantRepository

  attr_reader :filename

  def initialize(filename)
    @filename = filename
  end

  def all
    rows = CSV.read(@filename, headers: true, header_converters: :symbol)
    result = rows.map {|row| Merchant.new(row)}
  end

end
