require_relative 'merchant'
require 'pry'
class MerchantRepo

  attr_reader :merchants

  def initialize(file,se = nil)
    @merchants = {}
    open_file(file)

  end

  def open_file(file)
    CSV.foreach file,  headers: true, header_converters: :symbol do |row|
      data = row.to_h
      merchants[data[:id].to_i] = Merchant.new(data, self)
    end
  end

  def all
    merchants.values
  end

  def find_by_id(id)
    merchants[id]
  end

  def 



end
