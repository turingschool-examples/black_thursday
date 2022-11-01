class MerchantRepository
  attr_reader :merchants

  def initialize
    @merchants = []
  end

  def create(data)
    data[:id] ||= 1 if merchants == [] 
    data[:id] ||= (@merchants.last.id.to_i + 1).to_s 
    @merchants << Merchant.new(data)
  end

  def all
    @merchants
  end

  def find_by_id(id)
    select = merchants.select { |merchant| merchant.id == id }.first 
  end

  def find_by_name(name)
    select = merchants.select { |merchant| merchant.name.downcase == name.downcase }.first
  end

  def find_all_by_name(name)
    select = merchants.select { |merchant| merchant.name.downcase.include? "#{name.downcase}"}
  end

  def update(id, name)
    merchant = find_by_id(id)
    merchant.update(name)
  end
end
