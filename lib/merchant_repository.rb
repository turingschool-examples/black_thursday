require 'CSV'
require_relative 'merchant'
class MerchantRepository
  attr_reader :file_path, :all

  def initialize(file_path)
    @file_path = file_path
    @all =[]
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Merchant.new({:id =>row[:id], :name => row[:name]})
      # require 'pry';binding.pry
    end
  end
  def find_by_id(merchant_id)
    @all.find {|merchant| merchant.id == merchant_id}
  end
end
