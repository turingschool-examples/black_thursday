require './lib/csv_parser'
require './lib/merchant'

class MerchantRepository
include CsvParser
attr_accessor :merchants

  def initialize(file_name)
    @merchants = []
    merchant_parse_data(file_name)
  end

end
