class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at,
              :parent

  def initialize(data, parent = nil)
    @id =                          data[:id].to_i
    @invoice_id =                  data[:invoice_id].to_i
    @credit_card_number =          data[:credit_card_number].to_i
    @credit_card_expiration_date = data[:credit_card_expiration_date]
    @result =                      data[:result]
    @created_at =                  prep_time(data[:created_at])
    @updated_at =                  prep_time(data[:updated_at])
    @parent     =                  parent
  end

  def prep_time(time)
    return nil unless time
    Time.parse(time)
  end

  def invoice
    @parent.find_invoice_by_id(@invoice_id)
  end

  def is_successful?
    result == 'success'
  end

  def weekday_created
    @created_at.strftime("%A")
  end
end
