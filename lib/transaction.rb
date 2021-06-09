class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at,
              :repo

  def initialize(transaction_data, repo)
    @id                          = transaction_data[:id].to_i
    @invoice_id                  = transaction_data[:invoice_id].to_i
    @credit_card_number          = transaction_data[:credit_card_number]
    @credit_card_expiration_date = transaction_data[:credit_card_expiration_date]
    @result                      = transaction_data[:result].to_sym
    @created_at                  = Time.parse(transaction_data[:created_at].to_s)
    @updated_at                  = Time.parse(transaction_data[:updated_at].to_s)
    @repo                        = repo
  end

  def new_id(id_number)
    @id = id_number
  end

  def update_cc_number(attribute)
    return nil if attribute == nil
    @credit_card_number = attribute
  end

  def update_cc_expiration(attribute)
    return nil if attribute == nil
    @credit_card_expiration_date = attribute
  end

  def update_result(attribute)
    return nil if attribute == nil
    @result = attribute
  end

  def update_time
    @updated_at = Time.now
  end
end
