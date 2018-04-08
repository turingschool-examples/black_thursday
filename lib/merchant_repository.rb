# frozen_string_literal:true

require 'csv'
require './lib/merchant'

# A class for containing all Merchant objects
class MerchantRepository
  attr_reader :data_file,
              :by_id

  def initialize(data_file)
    @by_id = generate_merchants_data(data_file)
    # @by_name = {}
  end

  def generate_merchants_data(data_file)
    csv_string = File.read(data_file)
    data = CSV.parse(csv_string)
    create_index(data)
  end
  
  def create_index(data)
    merchant_information = data.shift
    merchant_data = {}
    data.each do |merchant|
      # require 'pry';binding.pry
      merchant_data[merchant[0]] = Merchant.new(merchant[0], merchant[1])
    end
    merchant_data
  end

  def all
  end
end
