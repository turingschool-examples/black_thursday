require 'pry'
class SalesEngine
  attr_reader :merchants

  def initialize(files_to_be_loaded)
    @merchants = MerchantRepository.new(files_to_be_loaded[:merchants])
  end

  def self.from_csv(files_to_be_loaded)
    SalesEngine.new(files_to_be_loaded)
  end

end
