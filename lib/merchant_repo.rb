require_relative "merchant"

class MerchantsRepo

  def initialize(csv_filepath)
    contents = CSV.open csv_filepath, headers: true, header_converters: :symbol
    @merchant_objects = contents.map do |row|
      Merchant.new(row)
    end
  end

  def all
    puts "#all"
    @merchant_objects # [Merchant{name: bob}, Merchant{name: frank}]
  end

end
