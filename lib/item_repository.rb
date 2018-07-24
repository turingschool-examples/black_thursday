require_relative 'item'
require_relative 'repository_module'

class ItemRepository
  include RepositoryModule

  def initialize(data_file)
    @repository = data_file.map {|item| Item.new(item)}
  end

  # def find_all_with_description(description)
  #   @repository.find_all do |item|
  #     item.attributes[:description] == description
  #   end
  # end
end
