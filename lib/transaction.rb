class Transaction
  attr_reader :id,
              :invoice_id, :credit_card_number, :result, :created_at

  attr_accessor :credit_card_number,
                :credit_card_expiration_date,       :result,      :updated_at

  def initialize(data)
    @id = data[:id].to_i
    @invoice_id = data[:invoice_id].to_i
    @credit_card_number = data[:credit_card_number]
    @credit_card_expiration_date = data[:credit_card_expiration_date]
    @result = data[:result].to_sym
    @created_at = data[:created_at].to_s
    @updated_at = data[:updated_at].to_s
  end

  def created_at
    if @created_at != nil
      Time.parse(@created_at)
    end
  end

  def updated_at
    if @updated_at != nil
      Time.parse(@updated_at)
    end
  end
end
