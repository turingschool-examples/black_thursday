require 'csv'
require 'pry'

class SalesEngine
  attr_reader :csv_content

  def initialize(csv_content={})
    @csv_content = csv_content
  end

  def self.from_csv(data)
    csv_content = {}
    data.each do |key, value|
      csv_content[key] = CSV.read(value, headers: true, header_converters: :symbol)
    end
    SalesEngine.new(csv_content)
  end

  def merchants
    MerchantRepository.new(@csv_content[:merchants])
  end

  def items
    ItemRepository.new(@csv_content[:items])
  end

end
