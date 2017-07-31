class Transaction
  attr_reader :id, :invoice_id, :credit_card_number,
              :credit_card_expiration_date, :result,
              :created_at, :updated_at, :parent

  def initialize(params, repo=nil)
    @id                          = params[:id].to_i
    @invoice_id                  = params[:invoice_id].to_i
    @credit_card_number          = params[:credit_card_number].to_i
    @credit_card_expiration_date = params[:credit_card_expiration_date]
    @result                      = params[:result]
    @created_at                  = Time.parse(params[:created_at].to_s)
    @updated_at                  = Time.parse(params[:updated_at].to_s)
    @parent                      = repo
  end
end
