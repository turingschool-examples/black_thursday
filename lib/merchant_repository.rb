require "csv"
require_relative "../lib/merchant"
class MerchantRepository
    def initialize(file_path)
      @merchants = populate_merchants(file_path)
    end

    def populate_merchants(file_path)
      file = CSV.read(file_path, headers: true, header_converters: :symbol )
      file.map do |row|
        Merchant.new(row)
      end
    end

    def all
      @merchants
    end

    def find_by_id(id)
      @merchants.find do |merchant|
        merchant.id == id
      end
    end

    def find_by_name(name)
      @merchants.find do |merchant|
        merchant.name.upcase == name.upcase
      end
    end

    def find_all_by_name(name)
      @merchants.find_all do |merchant|
        merchant.name.upcase.include?(name.upcase)
      end
    end

    def create(attributes)
      max_id = @merchants.max_by do |merchant|
        merchant.id.to_i
      end
      new_id = max_id.id.to_i + 1
      name = attributes[:name]
      new_merchant = Merchant.new({name: name, id: new_id.to_s})
      @merchants << new_merchant
      new_merchant
    end

    def update(id, attributes)
      merchant = find_by_id(id)
      #update merchant with given attribute
      new_name = attributes[:name]
      merchant.name = new_name
    end

    def delete(id)
      merchant = find_by_id(id)
      @merchants.delete(merchant)
    end

    def inspect
      "#<#{self.class} #{@merchants.size} rows>"
    end

end
