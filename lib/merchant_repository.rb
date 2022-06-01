require 'csv'
require_relative 'merchant'

class MerchantRepository
  attr_reader :all

  def initialize(file_path)
    @file_path = file_path
    @all = []

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Merchant.new({:id => row[:id], :name => row[:name]})
    end
  end

  def find_by_id(id)
    @all.find do |merchant|
      if merchant.id == id
        return merchant
      else
        nil 
      end
    end
  end
end
