require "csv"
class Merchant
  def initialize(mr, row)
    @id = row[:id]
    @name = row[:name]
  end
end

class MerchantRepo
  attr_reader :all
  @all = []
  CSV.foreach("./test/test_data/merchants_short.csv", headers: true, header_converters: :symbol) do |row|
    @all << Merchant.new(self, row)
    puts @all
  end

end

mr = MerchantRepo.new
puts mr.all.inspect
