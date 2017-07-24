require 'time'
class Invoice
  attr_reader :id, :customer_id, :merchant_id,
              :status, :created_at, :updated_at, :repo

  def initialize(params, repo=nil)
    @id          = params[:id]
    @customer_id = params[:customer_id]
    @merchant_id = params[:merchant_id]
    @status      = params[:status]
    @created_at  = params[:created_at]
    @updated_at  = params[:updated_at]
    @repo        = repo
  end
end
