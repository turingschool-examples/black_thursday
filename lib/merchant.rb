class Merchant

  attr_reader :id,
              :name

  def initialize(description)
    @id   = description[:id]
    @name = description[:name]
    @merchant_repo = description[:merchant_repo]
  end

end
