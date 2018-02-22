class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at,
              :parent

  def initialize(data, parent)
    @id = data[:id].to_i
    @invoice_id = data[:invoice_id].to_i
    @credit_card_number = data[:credit_card_number]
    @credit_card_expiration_date = data[:credit_card_expiration_date]
    @result = data[:result]
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
    @parent = parent
  end


  def invoice
    payload = ['transaction invoice', invoice_id]
    current_location = self
    while current_location.respond_to?('parent')
      current_location = current_location.parent
    end
    current_location.route(payload)
  end[0]
end
