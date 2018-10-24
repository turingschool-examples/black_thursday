class MerchantRepository
  attr_reader

  def initialize(data)
    @merchant_data  = CSV.open(data, headers: true, header_converters: :symbol)
    @collection = []
  end

  def merchants
    @merchant_data.each do |row|
      @collection << Merchant.new({id: "#{row[:id]}", name: "#{row[:name]}"})
    end
    @collection
  end
end
