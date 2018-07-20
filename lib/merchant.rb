class Merchant

  attr_reader :name,
              :id

  def initialize(id_and_name)
    @name = id_and_name[:name]
    @id = id_and_name[:id]

  end

end
