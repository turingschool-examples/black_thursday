require './lib/merchants'
require 'csv'

class MerchantRepo

  def initialize(csv_files)
    @merchants_list = merchant_instances(csv_files)
  end

  def merchant_instances(csv_files)
    merchants = CSV.open(csv_files, headers: true,
    header_converters: :symbol)

    @merchants_list = merchants.map do |merchant|
      Merchant.new(merchant)
    end
  end
end
