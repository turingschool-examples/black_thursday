require 'csv'
require_relative 'merchant'

class MerchantRepo
  attr_reader :merchants


  def initialize(csv_file)
    @merchants = []
    open_file(csv_file)

  end

  def open_file(file)
    CSV.foreach(file,  headers: true, header_converters: :symbol) do |row|
      merchants << Merchant.new(row)
    end

  end
end
