require 'csv'

class ItemRepository
  attr_reader :data_file,
              :items

  def initialize(csv_parsed_array)
    @items = create_index(csv_parsed_array)
  end

  def create_index(csv_data)
    csv_data.shift
    merchant_data = {}
    csv_data.each do |merchant|
      merchant_data[merchant[0]] = Merchant.new(merchant[0], merchant[1])
    end
    merchant_data
  end
end
