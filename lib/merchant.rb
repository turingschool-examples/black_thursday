require_relative 'merchant_repository'
# silence hound
class Merchant
  attr_reader :id,
              :created_at,
              :updated_at,
              :repository,
              :name
  attr_writer :name,
              :updated_at

  def initialize(merchant_info)
    @id = merchant_info[:id].to_i
    @name = merchant_info[:name]
    @created_at = merchant_info[:created_at]
    @updated_at = merchant_info[:updated_at]
    # @created_at = if merchant_info[:created_at] != nil
    #   merchant_info[:created_at]
    # else
    #   Time.now.to_s
    # end
    # @updated_at = if merchant_info[:updated_at] != nil
    #   merchant_info[:updated_at]
    # else
    #   Time.now.to_s
    # end
    @repository = merchant_info[:repository]
  end
end
