require_relative '../lib/merchant'
require_relative '../lib/repository'

class MerchantRepository < Repository

  def initialize(path)
    super(path)
    @array_of_objects = create_merchants(@parsed_csv_data)
  end

  def create_merchants(parsed_csv_data)
    parsed_csv_data.map do |merchant|
      Merchant.new(merchant)
    end
  end

  def inspect
  "#<#{self.class} #{@array_of_objects.size} rows>"
  end

  def all
    @array_of_objects
  end

  def find_by_id(id)
    @array_of_objects.find do |merchant|
      merchant.id == id
    end
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

  def create(attributes)
    @name = attributes[:name]
    @array_of_objects.push(Merchant.new({:id => new_id_number, :name => @name}))
  end

  def new_id_number
    (@array_of_objects.last.id)+1
  end

  def update(id, attributes)
    target = find_by_id(id)
    if !target.nil?
      target.name = attributes[:name]
    else
      nil
    end
  end

  def delete(id)
    target = find_by_id(id)
    @array_of_objects.delete(target)
  end
end
