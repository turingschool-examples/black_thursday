class MerchantRepository
  attr_reader

  def initialize(data)
    @merchant_data  = CSV.open(data, headers: true, header_converters: :symbol)
    @merchant_objects = []
  end

  def merchants
    @merchant_data.each do |row|
      @merchant_objects << Merchant.new({id: "#{row[:id]}", name: "#{row[:name]}"})
    end
    @merchant_objects
  end
end
