require 'csv'

module MerchantRepository

  def open_csv
  lines = CSV.open "merchants.csv"
  lines.each do |line|
    puts line
  end
end
