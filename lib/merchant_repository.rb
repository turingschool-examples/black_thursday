require_relative 'merchant'
require_relative 'repository_module'

class MerchantRepository
  include RepositoryModule

  def initialize(data_file)
    @repository = data_file.map {|merchant| Merchant.new(merchant)}
  end

  def find_all_by_name(name)
    @repository.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def create_new_id_number
    max_id = @repository.max_by(&:id).id
    new_id = max_id + 1
  end

  def create(attributes)
    new_id = create_new_id_number
    new_merchant = Merchant.new(
      name: attributes[:name],
      id: new_id,
      created_at: Time.now,
      updated_at: Time.now
    )
    @repository << new_merchant
    new_merchant
  end

  def update(id, attributes)
    if merchant = find_by_id(id)
      merchant.name = attributes[:name]
      merchant.updated_at = Time.now
      merchant
    else
      'Record not found.'
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end

# def create_new_id_number
#   max_id = @repository.max do |object|
#     object.id
#   end
#   new_id = max_id.id + 1
# end
