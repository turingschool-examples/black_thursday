# require './data/merchants.csv'
require 'csv'

class MerchantRepository

  attr_reader     :all

  def initialize
    @all = []
  end

  def populate(filename)
    contents = CSV.open(filename, headers: true,
     header_converters: :symbol)

    contents.each do |row|
      @all << Merchant.new(row, self)
    end
  end

  def find_by_id(id)
    @all.find do |merchant|
      merchant.id.to_i == id
    end
  end

  def find_by_name
  end

  def find_all_by_name
  end


end
