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

  def find_by_name(name)
    name_1 = name.downcase

    @all.find do |merchant|

      merchant.name.downcase
      merchant.name == name_1
    end
  end

  def find_all_by_name(name)
    name_1 = name.downcase

    @all.find_all do |merchant|
      #require "pry"; binding.pry
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
     #require "pry"; binding.pry
    @all.push(new)
    #require "pry"; binding.pry
  end

  def update(id, attributes)

    merchant = @all.find do |merchant|
      merchant.id == id
    end
    merchant.name = attributes[:name] if attributes[:name]


    # @all.find do |merchant|
    #   merchant.id == id
    #   merchant.name = attributes.values
    #   new_name << merchant.name
    #   require "pry"; binding.pry
    

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
