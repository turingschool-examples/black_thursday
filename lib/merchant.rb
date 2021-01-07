class Merchant
  attr_accessor :name
  attr_reader :id,
              :merchant_repo

  def initialize(info, merchant_repo)
    @id = info[:id].to_i
    @name = info[:name]
    @merchant_repo = merchant_repo
  end
end
