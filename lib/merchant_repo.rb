require 'csv'

class MerchantRepo

  attr_reader :merchants

  def initialize
    @merchants = []
  end

  def load_file(file_location)
    CSV.foreach(file_location, headers: true, header_converters: :symbol) do |line|
      add_merchant(line.to_h)
    end
    @merchants
  end

  def add_merchant(merchant)
    @merchants << Merchant.new(merchant)
  end

  def find_by_id(id)
    @merchants.find do |merchant|
      merchant.id.to_i == id
    end
  end
end
