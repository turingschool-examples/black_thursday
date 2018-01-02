require 'CSV'

class MerchantRepository
  attr_reader :contents

  def initialize(file_path = "./data/merchants.csv")
    @contents = CSV.open(file_path, headers: true, header_converters: :symbol)
  end

end
