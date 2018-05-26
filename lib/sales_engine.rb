require_relative 'csv_parser'
require_relative 'merchant_repository'
require 'pry'

class SalesEngine
  attr_reader :file_path

  def initialize(file_path)
    @csv_parser = CsvParser.new
    @file_path = file_path
  end

  def self.from_csv(file_path)
    SalesEngine.new(file_path)
  end

  def merchants
    @merchants ||= MerchantRepository.new(@csv_parser.load_csv(file_path[:merchants]))
  end
end
