require_relative 'merchant_repository'
require_relative 'sales_engine'
require_relative 'item_repository'
require_relative 'item'
require_relative 'merchant'
require 'csv'
require 'pry'

module CsvParser
  def open_file(file)
    CSV.open file, headers: true, header_converters: :symbol 
  end
end
