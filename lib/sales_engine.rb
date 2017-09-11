class SalesEngine
  attr_reader :merchants
  def initialize
    @merchants = :merchants
  end

  def from_csv(data_files)
    data_files.keys[0] = MerchantRepository.new(data_files.values[0])
  end
#data file will equal instance of repo
end
