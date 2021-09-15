require 'csv'
# require './merchant'
# require './data/merchants'

module MerchantRepository
  @@file_name = "sample.csv"
  def self.all
    rows = CSV.read(@@file_name, headers: true)
    empty_array = []
    empty_array << rows.by_row

    p empty_array
  end



end
