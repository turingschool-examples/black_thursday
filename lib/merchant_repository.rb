require_relative 'sales_engine'
require_relative 'merchant'

class MerchantRepository
  attr_reader :merchants

  def initialize(path)
    @merchants = []
    make_merchants(path)
  end

  def make_merchants(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      @merchants << Merchant.new(row)
    end
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find do |merchant|
      merchant.id == id
    end
  end
end