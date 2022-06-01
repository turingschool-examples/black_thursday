require 'CSV'
class MerchantRepository

  attr_reader :merchants,
              :all

  def initialize(file_path)
    @file_path = file_path
    @all = []
    CSV.foreach(@file_path, headers: true, header_converters: :symbol) do |row|
      @all << Merchant.new(row)
      # require "pry"; binding.pry
    end
    @all
  end

  def self.from_csv(data)
    MerchantRepository.new(data[:merchants])
  end

end
