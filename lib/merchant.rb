class Merchant
  attr_accessor :id,
                :name,
                :repo

  def initialize(merchant_info, repo)
    @id = merchant_info[:id].to_i
    @name = merchant_info[:name]
    @repo = repo
  end
end
