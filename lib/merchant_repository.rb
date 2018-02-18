require 'csv'
require_relative 'merchant'

class MerchantRepository
  attr_reader :merchant_csv_path, :parent
  def initialize(merchant_csv_path, parent)
    @merchant_csv_path = merchant_csv_path
    @parent            = parent
  end

  def all
    merchants = []
    contents = CSV.open @merchant_csv_path, headers: true
    contents.each do |row|
      merchants << Merchant.new(id: row[0], name: row[1])
    end
    merchants
  end

  def find_by_id

  end

end
