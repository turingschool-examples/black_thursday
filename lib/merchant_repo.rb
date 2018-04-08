require 'csv'
require_relative 'merchant'

class MerchantRepo
  attr_reader :all


  def initialize(csv_file)
    @all = []
    open_file(csv_file)

  end

  def open_file(file)
    CSV.foreach(file,  headers: true, header_converters: :symbol) do |row|
      all << Merchant.new(row)
    end
  end
end
