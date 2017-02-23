require_relative 'csv_parser'

module RepositoryCreators
  
  include CsvParser

  def create_merchant_repository(files)
    MerchantRepository.new(files[:merchants])
  end

  def create_item_repository

  end
end