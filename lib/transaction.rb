class Transaction
  attr_reader :id, :invoice_id, :cc_num, :cc_exp,
              :result, :created_at, :updated_at

  def initialize(params, repo=nil)
    @id         = params[:id].to_i
    @invoice_id = params[:invoice_id].to_i
    @cc_num     = params[:credit_card_number]
    @cc_exp     = params[:credit_card_expiration_date]
    @result     = params[:result]
    @created_at = Time.parse(params[:created_at].to_s)
    @updated_at = Time.parse(params[:updated_at].to_s)
  end
end
