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
      id = @merchants[-1].id + 1
      name = new_name[:name]
      new_merch = Merchant.new({id: id, name: name})
      @merchants << new_merch
      new_merch
    end

    def update(id, attribute)
      all
      if attribute.keys.include?(:name) == true
          if find_by_id(id) != nil
              @merchants.delete(find_by_id(id))
              create(attribute)
            end
          end
    end

    
end
