require_relative 'merchant.rb'

class MerchantRepository
  attr_reader :merchants, :repository
  def initialize(merchants)
    @merchants = merchants
    @repository = make_repository
  end

  def make_repository
    @merchants.map do |merchant|
      merchant = Merchant.new(merchant)
    end
  end

  def all
    @repository
  end

  def find_by_id(id)
    found = @repository.select { |merchant| merchant.id == id }
    found[0]
  end

  def find_by_name(name)
    found = @repository.select { |merchant| merchant.name == name }
    found[0]
  end

  def find_all_by_name(name)
    found = @repository.select { |merchant| merchant.name.include?(name) }
  end

  def create(name)
    max_id = @repository.sort_by{ |merchant| merchant.id }.last.id
    new_id = max_id + 1
    new_merchant = Merchant.new({
                    id: new_id.to_s,
                    name: name,
                    created_at: Time.now,
                    updated_at: Time.now
                    })
    @repository << new_merchant
    new_merchant
  end

  def update(id, attributes)
    new_name = attributes
    merchant = find_by_id(id)
    merchant.name = new_name
    merchant
  end

end
