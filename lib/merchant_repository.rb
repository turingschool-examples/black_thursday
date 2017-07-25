require_relative 'merchant'
require 'csv'
require 'pry'

class MerchantRepository
  def initialize(data)
    load_csv_file(data)
  end

  def load_csv_file(data)
    contents = CSV.open data, headers: true, header_converters: :symbol
    contents.each do |row|
      id = row[:id]
      name = row[:name]
      created_at = row[:created_at]
      updated_at = row[:updated_at]
    end
  end
end
