class Merchant

  attr_reader :id,
              :name

  def initialize(description)
    @id   = description[:id]
    @name = description[:name]
  end

end
