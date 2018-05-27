require_relative 'repo_methods.rb'
require_relative 'merchant.rb'
class MerchantRepository
  include RepoMethods
  def initialize(data_from_csv)
    @collection = get_data_from_csv(data_from_csv)
  end
  # def make_collection(data_from_csv)
  #
  # end
  #
  # def get_data_from_csv(data_from_csv)
  #   data_from_csv.map do |line|
  #     Hash[line[:id], Merchant.new(line)]
  #   end
  # end
  # def create(attributes)
  #   new_merchant = Merchant.new(attributes)
  #   @collection << new_merchant
  #   new_merchant
  # end
  #
  # def update(current_id, new_attributes)
  #   merchant = find_by_id(current_id)
  #   merchant.update_name(new_attributes)
  # end
  #
  # def delete(id)
  #   merchant = find_by_id(id)
  #   @collection.delete(merchant)
  # end
  #
  # def find_by_id(id)
  #   @collection.detect do |merchant|
  #     merchant.id == id
  #   end
  # end
  #
  # def find_by_name(name)
  #   @collection.detect do |merchant|
  #     merchant.name == name
  #   end
  # end
  #
  # def find_all_by_name(name_fragment)
  #   matches = []
  #   @collection.each do |merchant|
  #     if merchant.name.include?(name_fragment)
  #       matches << merchant
  #     end
  #   end
  #   return matches
  # end
  #
  # def all
  #   @collection
  # end

end
