# frozen_string_literal:true

require 'csv'
require './lib/merchant'

# A class for containing all Merchant objects
class MerchantRepository
  attr_reader :data_file,
              :merchants

  def initialize(csv_parsed_array)
    @merchants = create_index(csv_parsed_array)
    # @by_name = {}
  end

  # def generate_merchants_data(data_file)
  #   csv_string = File.read(data_file)
  #   data = CSV.parse(csv_string)
  #   create_index(data)
  # end
  
  def create_index(csv_data)
    merchant_information = csv_data.shift
    merchant_data = {}
    csv_data.each do |merchant|
      merchant_data[merchant[0]] = Merchant.new(merchant[0], merchant[1])
    end
    merchant_data
  end
end
