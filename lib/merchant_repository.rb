class MerchantRepository
  attr_reader :all

  def initialize(merchants_path)
    @all = []

    CSV.foreach(merchants_path,     headers: true,     header_converters: :symbol) do |row|
      @all << Merchant.new({:id => row[:id], :name => row[:name]})
    end
  end
end
