require 'csv'
require_relative 'merchant'
class MerchantRepository
  def initialize(path)
    @merchants = []
    load_path(path)
  end

  def all
    @merchants
  end

  def load_path(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |data|
      @merchants << Merchant.new(data)
    end
  end
end
