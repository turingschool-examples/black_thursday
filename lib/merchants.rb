require 'csv'
require './lib/sales_engine'

class Merchants
  attr_reader   :id
  attr_accessor :name,
                :created_at,
                :updated_at

  def initialize(merchants)
    @id         = merchants[0]
    @name       = merchants[1]
    @created_at = merchants[2]
    @updated_at = merchants[3]
  end

  def hash_convert
    headers = []
    CSV.foreach('./data/merchants.csv', headers: true,
                                        header_converters: :symbol) do |row|
      headers << row
    end
    # names = headers.map do |name|
    #     name[:name]
    # end
  end

  def merchant_repo
    MerchantRepository.new(@merchants)
  end
end
