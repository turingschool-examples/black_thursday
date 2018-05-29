require_relative 'repo_methods'
require_relative 'item'
require 'bigdecimal'

class ItemRepository
  include RepoMethods
  attr_reader :collection

  def initialize(data_from_csv)
    @collection = get_data_from_csv(data_from_csv)
  end

  def create(attributes)
    attributes[:id] = new_id
    @collection[new_id] = Item.new(attributes)
  end
end
