class MerchantRepository
  def initialize(argument)
    @argument = argument
  end
  def all
    # CSV.foreach(:merchants, headers: true, header_converters: :symbol) do |row|
    #   @merchant_list << Merchant.new(row)
  end
end
@merchant_list = []
