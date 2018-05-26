require_relative 'csv_parser'
require_relative 'merchant_repository'
require 'pry'

class SalesEngine
  def initialize
    @csv_parser = CsvParser.new
  end

  def from_csv(file_path)
    @merchants ||= MerchantRepository.new([:merchants] = merchants)
  end

  def merchants
    @csv_parser.load_csv('./data/merchants.csv')
  end

  def items
    #instantiiates the items repository.
  end
end
