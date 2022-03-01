require "pry"

class MerchantRepository
  attr_reader :file_path, :merchants
  def initialize(file_path)
    @file_path = file_path
    @merchants = all
  end

  def all
    merchants = CSV.read(@file_path, headers: true, header_converters: :symbol)
    merchants_instances_array = []
    merchants.by_row!.each do |row|
      merchants_instances_array << Merchant.new(row)
    end
    merchants_instances_array
  end

  def find_by_id(id)
    merchants.find do |merchant_instance|
      merchant_instance.merchant_attributes[:id] == id
    end
  end

  def find_by_name(name)
    merchants.find do |merchant_instance|
      merchant_instance.merchant_attributes[:name] == name.downcase
    end
  end

  def find_all_by_name(fragment)
    merchants.find_all do |merchant_instance|
      merchant_instance.merchant_attributes[:name].include?(fragment)
    end
  end

  def create(attributes)
    attributes[:id] = merchants[-1].merchant_attributes[:id] + 1
    merchants << Merchant.new(attributes)
  end

  def update(id, attributes)
      if attributes.include?(:name)
        find_by_id(id).merchant_attributes[:name] = attributes[:name]
      end
    end

  def delete(id)
    merchants.delete(find_by_id(id))
  end
end
