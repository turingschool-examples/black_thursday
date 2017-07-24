class Merchant

attr_reader :id,
            :name

  def initialize(data)
    @data = data
    @id = data[:id]
    @name = data[:name]
  end

  def convert_to_hash
    @data.to_hash
  end

end
