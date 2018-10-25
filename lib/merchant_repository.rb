require_relative './merchant'
require_relative './repo_module'

class MerchantRepository
  include RepoModule

  attr_reader :all

  def initialize(file_path)
    @class_name = Merchant
    @all = from_csv(file_path)
  end

  def find_all_by_name(merchant_name)
    @all.find_all do |merchant|
      merchant.name.downcase.include?(merchant_name.downcase)
    end
  end
end
