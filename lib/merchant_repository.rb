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

end
