require_relative 'merchant'
require_relative 'repo_methods'

class MerchantRepository
  include RepoMethods
  def initialize(merchant_data)
    @merchant_rows ||= build_merchant(merchant_data)
    @repo = @merchant_rows #shops = an array of merchants, might change this name
  end

  def build_merchant(merchant_data)
    merchant_data.map do |merchant|
      Merchant.new(merchant)
    end
  end

  def find_all_by_name(fragment)
    @repo.find_all do |merchant|
      merchant.name.downcase.include?(fragment.downcase)
    end
  end

  def create(attributes)
    id = create_id
    merchant = Merchant.new(
      id: id,
      name: attributes[:name],
      created_at: Time.now,
      updated_at: Time.now,
      )
    @repo << merchant
    merchant
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    return if merchant.nil?
    merchant.name = attributes[:name] || merchant.name
    merchant.updated_at = Time.now
    merchant
  end

end
