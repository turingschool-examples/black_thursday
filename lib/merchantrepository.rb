require 'csv'
require_relative 'merchant'

class MerchantRepository
  attr_reader :all

  def initialize(file_path, engine)
    @engine = engine
    @all = create_repository(file_path)
  end

  def create_repository(file_path)
    all = []

    csv = CSV.read(file_path, headers: true, header_converters: :symbol)
     csv.map do |row|
       all << Merchant.new(row)
    end
    all
  end

  def find_by_id(id)
    @all.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(search_term)

    @all.find do |merchant|
      ne = merchant.name.downcase
      ne == search_term.downcase
    end
  end

  def find_all_by_name(name)
    name_1 = name.downcase

    @all.find_all do |merchant|
      name = merchant.name
      name.downcase.include?(name_1)
    end

  end

  def create(attributes)
    id_max = @all.max_by {|merchant| merchant.id}

    attributes[:id] = id_max.id + 1
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    new = Merchant.new(attributes)
    @all.push(new)
  end

  def update(id, attributes)
    updated_merchant = self.find_by_id(id)
    if updated_merchant != nil
      updated_merchant.name = attributes[:name] if attributes[:name]
      updated_merchant.updated_at = Time.now
    end
  end

  def delete(id)
    @all.delete_if do |row|
      row.id == id
    end
  end

  def inspect
   "#<#{self.class} #{@merchants.size} rows>"
 end
end
