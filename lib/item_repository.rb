require_relative 'repo_methods.rb'
require_relative 'item.rb'

class ItemRepository
  include RepoMethods
  attr_reader :collection

  def initialize(data_from_csv)
    @collection = get_data_from_csv(data_from_csv)
  end

end
