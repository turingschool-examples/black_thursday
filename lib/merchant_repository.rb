require 'pry'
class MerchantRepository
attr_reader :data, :merchants
    def initialize(data)
      @data = data #data is an array of merchant instances
    end

    def all

      @merchants = []
      @data.each_with_index do |line, index|
        next if index == 0
        columns = line.split(",")
        @merchants << Merchant.new({id: columns[0], name: columns[1], start_date: columns[2], end_date: columns[3]})
      end

    end

end
