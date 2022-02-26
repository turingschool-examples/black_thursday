require 'pry'
require_relative 'merchant'

class MerchantRepository
attr_reader :data, :merchants
    def inspect
    "#<\#{self.class} \#{@merchants.size} rows>"
    end

    def initialize(data)
      @data = File.readlines data
      @merchants = []
    end

    def all
      @data.each_with_index do |line, index|
        next if index == 0
        columns = line.split(",")
        @merchants << Merchant.new({id: columns[0], name: columns[1], created_at: columns[2], updated_at: columns[3]})
      end
    end

    def find_by_id(id)
      all
      @merchants.find {|merchant| merchant.id == id}
    end

    def find_by_name(name)
      all
      @merchants.find {|merchant| merchant.name == name.downcase}
    end

    def find_all_by_name(fragment)
      all
      @merchants.find_all {|merchant| merchant.name.downcase.include?(fragment.downcase)}
    end

    def create(new_name)
      all
      id = @merchants[-1].id + 1
      name = new_name[:name]
      new_merch = Merchant.new({id: id, name: name, created_at: Time.now, updated_at: Time.now})
      @merchants << new_merch
      new_merch
    end

    def update(id, attribute)
      all
      if attribute.keys.include?(:name) == true
          if find_by_id(id) != nil
              merchant = find_by_id(id)
              merchant.name = attribute[:name]
              merchant.updated_at = Time.now
            end
        end
      merchant
    end

    def delete(id)
      all
      @merchants.delete(find_by_id(id)) if find_by_id(id) != nil
    end
end
