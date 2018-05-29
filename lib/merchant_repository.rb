require_relative 'repo_methods'
require_relative 'merchant'

class MerchantRepository
  include RepoMethods
  attr_reader :collection

  def initialize(data_from_csv)
    @collection = get_data_from_csv(data_from_csv)
  end

  def get_data_from_csv(data_from_csv)
    data_from_csv.map do |line|
      [line[:id].to_i, Merchant.new(line)]
    end.to_h
  end

  def create(attributes)
    attributes[:id] = new_id
    @collection[new_id] = Merchant.new(attributes)
  end
end
