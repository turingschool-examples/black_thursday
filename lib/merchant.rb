class Merchant

  attr_reader :name,
              :id,
              :created_at,
              :updated_at

  def initialize(merchant_info, merchant_repo)
    @name           = merchant_info[:name]
    @id             = merchant_info[:id].to_i
    @created_at     = merchant_info[:created_at]
    @updated_at     = merchant_info[:updated_at]
    @merchant_repo  = merchant_repo
  end



end
