class MerchantRepository

  def self.from_sales_engine(merchant_data)
    CSV.foreach(merchant_data, headers: true, header_converters: :symbol) do |row|
      @merchant << Merchant.new(row)
  end

  def initialize(merchant_data)
    @merchants = MerchantRepository.from_sales_engine(merchant_data)
  end

  def all
    @merchant_list
  end

  def turn_into_objects

    @merchant_list <<
  end

  def find_by_id(argument)
    @merchant_list[argument]
  end
end
@merchant_list = []
