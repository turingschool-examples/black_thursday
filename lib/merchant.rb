class Merchant
  attr_reader :name,
              :repository,
              :id

    def initialize(data, parent)
      @name = data[:name]
      @id = data[:id]
      @repository = parent
    end

end
