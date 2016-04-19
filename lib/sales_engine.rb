class SalesEngine
  attr_reader :merchants_data

  def self.from_csv(csv_content)
    @merchants_data = CsvParser.new.merchants(csv_content)
  end

  def merchants
    MerchantRepository.new(merchants_data)
  end

end
