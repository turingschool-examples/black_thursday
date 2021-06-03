require 'CSV'
class Merchant
  attr_reader :id, :name, :created_at, :updated_at, :repo

  def initialize(merchant_data, repo)
    @id = merchant_data[:id].to_i
    @name = merchant_data[:name]
    @created_at = merchant_data[:created_at]
    @updated_at = merchant_data[:updated_at]
    @repo = repo
  end

  def change_name(name)
    @name = name
  end
end
