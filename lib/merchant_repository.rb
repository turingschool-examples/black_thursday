require 'csv'
require 'pry'
require './lib/merchant'

class MerchantRepository

  attr_reader :all

  def initialize(file_path)
    @file_path = file_path
    @all = []

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Merchant.new(row[:id],row[:name])
    end
  end

  def find_by_id(id_number)
    @all.find {|merchant| merchant.id == id_number.to_s}
  end

end
