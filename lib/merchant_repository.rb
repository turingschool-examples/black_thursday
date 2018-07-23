require_relative 'merchant'
class MerchantRepository

  def initialize(data_file)
    @repository = data_file.map {|merchant| Merchant.new(merchant)}
  end

  def all
    @repository.find_all do |merchant|
      merchant
    end
  end

  def find_by_id(id)
    @repository.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @repository.find do |merchant|
      merchant.name.downcase == name.downcase
    end
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

  def delete(id)
    merchant = find_by_id(id)
    @repository.delete(merchant)
  end
end

# def create_new_id_number
#   max_id = @repository.max do |object|
#     object.id
#   end
#   new_id = max_id.id + 1
# end
