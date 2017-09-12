class Merchant

  def self.load_from_csv(csv)
    id = csv[:id]
    name = csv[:name]
  end

  attr_reader :id, :name

  def initialize(id, name)
      @id = id
    @name = name
  end

end
