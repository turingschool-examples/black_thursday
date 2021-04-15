require './merchant_repository'
# silence hound
class Merchant
  attr_reader :id,
              :created_at,
              :updated_at,
              :repository
  attr_accessor :name

  def initialize(merchant_info, repository)
    @id = merchant_info[:id]
    @name = merchant_info[:name]
    @created_at = if merchant_info[:created_at] != nil
      merchant_info[:created_at]
    else
      Time.now
    end
    @updated_at = if merchant_info[:updated_at] != nil
      merchant_info[:updated_at]
    else
      Time.now
    end
    @repository = repository
  end
end
