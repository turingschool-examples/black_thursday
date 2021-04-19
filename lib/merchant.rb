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
    @repository = merchant_info[:repository]
  end

  def update(attributes)
    @name = attributes[:name] unless attributes[:name].nil?
    @updated_at = Time.now
  end
end
