require_relative 'sales_engine'

class MerchantRepository
  # attr_reader :all_merchants

  def initialize(file_path)
    @file_path = file_path.to_s
    # @all_merchants = Array.new
  end

  def read_csv
    collection_array = []
    data = CSV.parse(File.read(@file_path), headers: true) do |line|
      collection_array << line.to_h
    end
    # require "pry"; binding.pry
    collection_array
  end

end
