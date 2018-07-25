require './lib/csv_adaptor'

class SalesEngine
  
  include CsvAdaptor

  def initialize
    @merchants = MerchantRepo.new
    @items = ItemRepo.new
  end

  def from_csv(file_location)
    load_from_csv(file_location)
  end

end

