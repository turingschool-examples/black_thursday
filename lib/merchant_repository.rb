class MerchantRepository
  attr_reader :all

  def initialize(path)
    @path = path
    @all = generate
  end

  def generate
    CSV.readlines(@path).drop(1).map do |line|
      id,name,created_at,updated_at = line
      Merchant.new({
          :id => id.to_i,
          :name => name,
          :created_at => created_at,
          :updated_at => updated_at
          })
    end
  end

  def find_by_id(id)
    @all.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @all.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    @all.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def new_id
    max_id = @all.max_by do |merchant|
      merchant.id
    end
    max_id.id += 1
  end

  def create(attributes)
    Merchant.new({:id => new_id,
              :name => attributes[:name]
              })
  end

  def update(id, attributes)
    update_merchant = find_by_id(id)
    update_merchant.id = attributes[:id]
    update_merchant.name = attributes[:name]
  end

  def delete(id)
    deleted_merchant = find_by_id(id)
    @all.delete(deleted_merchant)
  end
end
