require_relative 'repo_methods'
require_relative 'merchant'

class MerchantRepository
  include RepoMethods
  attr_reader :collection

  def initialize(data_from_csv)
    @collection = get_data_from_csv(data_from_csv)
  end
end
