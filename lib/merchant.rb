
class Merchant
  attr_reader :id, :name, :repository

  def initialize(merchant_hash, repository)
    @repository = repository
    @id = merchant_hash[:id].to_i
    @name = merchant_hash[:name]
  end

  def items
    # ask the thing that has item array (item_repo)
    # iterate through it
    # match all item objects with current merchant by id
    # find_all

    repository.find_items



  end

end
