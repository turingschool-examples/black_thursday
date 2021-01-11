class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at,
              :parent

  def initialize(args, parent)
    @args                        = args
    @id                          = args[:id].to_i
    @invoice_id                  = args[:invoice_id].to_i
    @credit_card_number          = args[:credit_card_number].to_s
    @credit_card_expiration_date = args[:credit_card_expiration_date].to_s
    @result                      = args[:result].to_s
    @created_at                  = Time.parse(args[:created_at].to_s)
    @updated_at                  = Time.parse(args[:updated_at].to_s)
    @parent                      = parent
  end

  def update(args)
    @credit_card_number = (args[:credit_card_number].to_s) if !args[:credit_card_number].nil?
    @credit_card_expiration_date = (args[:credit_card_expiration_date].to_s) if !args[:credit_card_expiration_date].nil?
    @result = (args[:result].to_s) if !args[:result].nil?
    @updated_at  = Time.now
  end
end
