require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'sales_analyst'
require 'csv'
require 'pry'

class SalesEngine
  attr_reader :csv_content, :merchants, :items, :sales_analyst

  def initialize(csv_content={})
    @csv_content = csv_content
    @merchants ||= MerchantRepository.new(@csv_content[:merchants], self)
    @items ||= ItemRepository.new(@csv_content[:items])
    @sales_analyst ||= SalesAnalyst.new(self)
  end

  def self.from_csv(data)
    csv_content = {}
    data.each do |key, value|
      csv_content[key] = CSV.read(value, headers: true, header_converters: :symbol)
    end
    SalesEngine.new(csv_content)
  end

end
