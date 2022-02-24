class MerchantRepository

    def initialize(data)
      @data = data #data is an array of merchant instances
    end

    def all
      @data
    end

end
