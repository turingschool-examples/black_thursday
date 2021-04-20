require_relative '../lib/merchant'
require_relative '../lib/repository'

class MerchantRepository < Repository

  def initialize(path)
    super(path, Merchant)
  end

  def inspect
  "#<#{self.class} #{@array_of_objects.size} rows>"
  end

  def find_by_name(name)
    @array_of_objects.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    full_names = []
    @array_of_objects.each do |merchant|
      if merchant.name.downcase.include?(name.downcase)
        full_names.push(merchant)
      end
    end
    full_names
  end

  def update(id, attributes)
    target = find_by_id(id)
    if !target.nil?
      target.name = attributes[:name]
    else
      nil
    end
  end

end
