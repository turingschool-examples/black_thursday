class MerchantRepository

  def initialize(data)
    @merchant_data  = CSV.open(data, headers: true, header_converters: :symbol)
    @collection = []
  end

  def merchants
    @merchant_data.each do |row|
      @collection << Merchant.new({id: "#{row[:id]}", name: "#{row[:name]}"})
    end
    @collection
  end

  def all
    @collection
  end

  def find_by_id(id)
    @collection.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @collection.find do |merchant|
      merchant.name == name
    end
  end

  def find_all_by_name(name)
    name_case = name.downcase
    @collection.find_all do |merchant|
      merchant.name.downcase.include?(name_case)
    end
  end

  def create(attribute)
    highest = @collection.max_by do |merchant|
      merchant.id.to_i
    end
    number = (highest.id.to_i + 1).to_s
    new_merchant = Merchant.new({ id: number, name: attribute })
    @collection << new_merchant
    new_merchant
  end

  def update(id, attribute)
    find_by_id(id).name = attribute
  end

  def delete(id)
    @collection.delete_if do |merchant|
      merchant.id == id
    end
  end
end
