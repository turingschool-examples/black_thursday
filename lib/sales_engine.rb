class SalesEngine

  def self.from_csv(data_files)
    data_files.for_each do |key, value|


      # data_files.keys[0] = MerchantRepository.new(data_files.values[0])
  end

  attr_reader :items,
  :merchants

  def initialize
    @items = items
    @merchants = merchants
  end

#data file will equal instance of repo
end
