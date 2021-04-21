require_relative '../lib/merchant'
require_relative '../lib/repo_module'

class MerchantRepository
  include RepoModule
# The MerchantRepository is responsible for holding and
# searching our Merchant instances.

  def initialize
    @data = []
  end

  def find_all_by_name(search_name)
    @data.find_all do |merch|
      merch.name.downcase.include?(search_name.downcase)
    end
  end

  def create(attributes)
    if attributes.class == Hash
      merchant = Merchant.new({id: find_next_id, name: attributes[:name]})
    else
      merchant = Merchant.new({
        id: attributes[:id].to_i,
        name: attributes[:name]
        })
    end
    @data << merchant
  end

  def update(id, attributes)
    if find_by_id(id) != nil
      update_attributes(id, attributes)
    end
  end
end
