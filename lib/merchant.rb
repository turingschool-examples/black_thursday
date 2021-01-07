require './lib/merchant_repository'

class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at

  def initialize(data, repository)
    @repository = repository
    @id = data[:id]
    @name = data[:name]
    @created_at = Time.parse(data[:created_at].to_s)
    @updated_at = Time.parse(data[:updated_at].to_s)
  end
end
