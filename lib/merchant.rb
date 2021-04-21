class Merchant
  attr_accessor :id,
                :name

  def initialize(merchant_info, repo)
    @id = merchant_info[:id].to_i
    @name = merchant_info[:name]
    @repo = repo
  end

  def update_name(attributes)
    @name = attributes[:name]
  end
end
