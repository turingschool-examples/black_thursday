require "pry"

class Merchant

  attr_reader :name, :id, :merchant_repository

  def initialize(merchant_data, merchant_repository)
    @mr = merchant_repository
    @name  = merchant_data[:name].to_s
    @id = merchant_data[:id].to_i

  end
end
