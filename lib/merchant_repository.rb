require 'CSV'
require_relative 'merchant'

class MerchantRepository
  attr_reader :all

  def initialize(file_path)
    @file_path = file_path
    @all = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Merchant.new({
        :id => row[:id],
        :name => row[:name]
        })
      end
        # require "pry"; binding.pry
  end



end
