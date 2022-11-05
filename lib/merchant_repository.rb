class MerchantRepository
  attr_reader :merchants

  def initialize
    @merchants = []
  end

  def create(attributes)
    attributes[:id] = (@merchants[-1].id + 1) if merchants[0]
    new_merchant = Merchant.new(attributes)
    @merchants << new_merchant
    new_merchant
  end

  def all
    @merchants
  end

  def find_by_id(id)
    merchants.find { |merchant| merchant.id == id }
  end

  def find_by_name(name)
    merchants.find do |merchant|
      merchant.name.casecmp?(name)
    end
  end

  def find_all_by_name(name)
    merchants.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def delete(id)
    merchants.delete_if { |merchant| merchant.id == id }
  end

  def update(id, attributes)
    unless find_by_id(id).nil?
      find_by_id(id).name = attributes[:name]
    end
  end

  def parse_data(file)
    rows = CSV.open file, headers: true, header_converters: :symbol
    rows.each do |row|
      new_obj = Merchant.new(row.to_h)
      merchants << new_obj
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
