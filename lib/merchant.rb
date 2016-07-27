class Merchant
  attr_reader :id,
              :name,
              :repo

  def initialize(merchant_details, repo = nil)
    @id   = merchant_details[:id].to_i
    @name = merchant_details[:name]
    @repo = repo
  end
end
