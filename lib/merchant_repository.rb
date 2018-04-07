class MerchantRepository
  attr_reader :data_file

  def initialize(data_file)
    @data_file = data_file
  end
end
