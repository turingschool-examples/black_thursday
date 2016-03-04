require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'sales_analyst'
require 'csv'
require 'pry'

class SalesEngine
  attr_reader :data, :merchants, :items, :sales_analyst

  def initialize(data={})
    # takes in data as a hash containing keys like :merchants, :items, :etc
    # generates and stores repos for each data type
    # {:merchants => [{:some => "merchant data"}]}
    @data = data
    # only create this if the csv_content for :merchants is provided
    @merchants = MerchantRepository.new(@data[:merchants], self)
    @items     = ItemRepository.new(@data[:items], self)
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
