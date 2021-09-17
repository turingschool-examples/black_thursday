class MerchantsRepository
  attr_reader :all

  def initialize(merchant_array)
    @all = merchant_array
  end

  def find_by_id(id)
    @all.find { |merchant| merchant.id == id }
  end

  def find_by_name(name)
    @all.find { |merchant| merchant.name.casecmp?(name) }
  end

  def find_all_by_name(name)
    @all.find_all { |merchant| merchant.name.upcase.include? name.upcase }
  end

  def create(attributes)
    new_id = max_merchant.id.to_i + 1
    new_merch_hash = {}
    new_merch_hash[:id] = new_id
    new_merch_hash[:name] = attributes
    @all.push(Merchant.new(new_merch_hash))
  end

  def max_merchant
    @all.max { |merch1, merch2| merch1.id <=> merch2.id }
  end

  def update(existing_name, new_name)
    merch_object = @all.find do |merchant|
      merchant.name == existing_name
    end
    merch_object.update_name(new_name)
  end

  def delete(id)
    merch_object = @all.find do |merchant|
      merchant.id == id
    end
    @all.delete(merch_object)
  end
end
