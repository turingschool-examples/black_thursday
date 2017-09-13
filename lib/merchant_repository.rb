require_relative 'merchant'
require_relative 'csv_loader'
require_relative 'search'

class MerchantRepository
  include CsvLoader
  include Search

  attr_reader :merchants

  def initialize(csv_file_name)
    @merchants = create_merchants(csv_file_name)
    return self
  end

  def create_merchants(csv_file_name)
    create_instances(csv_file_name, 'Merchant')
  end

  def find_by_id(search_id)
    find_instance_by_id(@merchants, search_id)
  end

  def find_by_name(search_name)
    find_instance_by_name(@merchants, search_name)
  end

  def find_all_by_name(search_all_name)
    search_all_name = search_all_name.downcase
    @merchants.find_all do |merchant|
      name = merchant.name.downcase
      name.include?(search_all_name)
    end
  end

end
