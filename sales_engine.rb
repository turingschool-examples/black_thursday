require_relative './lib/merchant_repository'
require_relative './lib/item_repository'
require 'csv'
require 'pry'

class SalesEngine
  attr_reader :csv_content, :merchants, :items

  def initialize(csv_content={})
    @csv_content = csv_content
    @merchants ||= MerchantRepository.new(@csv_content[:merchants], self)
    @items ||= ItemRepository.new(@csv_content[:items])
  end

  def self.from_csv(data)
    csv_content = {}
    data.each do |key, value|
      csv_content[key] = CSV.read(value, headers: true, header_converters: :symbol)
    end
    SalesEngine.new(csv_content)
  end

end
