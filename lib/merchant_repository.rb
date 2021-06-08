require_relative '../module/incravinable'

class MerchantRepository
  include Incravinable

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  attr_reader :all,
              :engine

  def initialize(path, engine)
    @all = []
    create_merchants(path)
    @engine = engine
  end

  def create_merchants(path)
    merchants = CSV.foreach(path, headers: true, header_converters: :symbol) do |merchant_data|
      merchant_hash = {
                        id: merchant_data[:id].to_i,
                        name: merchant_data[:name],
                        created_at: merchant_data[:created_at],
                        updated_at: merchant_data[:updated_at]
                      }
                      
      @all << Merchant.new(merchant_hash, self)
    end
  end

  def find_by_id(id)
    find_with_id(id, @all)
  end

  def find_by_name(name)
    find_with_name(name, @all)
  end

  def find_all_by_name(name)
    find_all_with_name(name, @all)
  end

  def create(attributes)
    highest_id = @all.max_by { |merchant| merchant.id }
    merchant = Merchant.new(attributes, self)
    merchant.new_id(highest_id.id + 1)
    @all << merchant
  end

  def update(id, attributes)
    found_merchant = @all.find do |merchant|
      merchant.id == id
    end
    if find_by_id(id) != nil
      found_merchant.update_name(attributes[:name])
      found_merchant.update_time
    end
  end

  def delete(id)
    remove(id, @all)
  end
end
