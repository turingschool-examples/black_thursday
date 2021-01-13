class Merchant
  attr_accessor :name
  attr_reader :id,
              :merchant_repo,
              :created_at

  def initialize(info, merchant_repo)
    @id = info[:id].to_i
    @name = info[:name]
    @created_at = Time.parse(info[:created_at])
    @merchant_repo = merchant_repo
  end
end
