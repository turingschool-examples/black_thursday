require 'pry'

class MerchantRepository
attr_reader :data, :merchants
    def initialize(data)
      @data = data
    end

    def all
      @merchants = []
      @data.each_with_index do |line, index|
        next if index == 0
        columns = line.split(",")
        @merchants << Merchant.new({id: columns[0], name: columns[1], start_date: columns[2], end_date: columns[3]})
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

    def find_all_by_name(frag)
      all
      @merchants.find_all {|merchant| merchant.name.downcase.include?(frag.downcase)}
    end

    def create(new_name)
      all
      id = @merchants.count + 1
      name = new_name[:name]
      Merchant.new({id: id, name: name})
    end

    def update(id, name_update)
      all
      @merchants.delete(find_by_id(id))
      create(name_update)
    end
end
