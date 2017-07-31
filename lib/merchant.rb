require_relative '../lib/merchant_repository'

class Merchant

  attr_reader :name,
              :id,
              :created_at,
              :updated_at,
              :merchant_repo

  def initialize(merchant_info, merchant_repo)
    @name           = merchant_info[:name]
    @id             = merchant_info[:id].to_i
    @created_at     = merchant_info[:created_at]
    @updated_at     = merchant_info[:updated_at]
    @merchant_repo  = merchant_repo
  end

  def items
    self.merchant_repo.merchant_repo_to_se(id)
  end

  def invoices
    self.merchant_repo.merchant_repo_to_se_invoices(id)
  end

  def customers
    self.merchant_repo.merchant_repo_to_se_customers(id)
  end

end
