class Transaction
  attr_reader :invoice_id,
              :created_at

  attr_accessor :id,
                :credit_card_number,
                :credit_card_expiration_date,
                :result,
                :updated_at

  def initialize(info_hash)
    @id = info_hash[:id].to_i
    @invoice_id = info_hash[:invoice_id].to_i
    @credit_card_number = info_hash[:credit_card_number]
    @credit_card_expiration_date = info_hash[:credit_card_expiration_date]
    @result = info_hash[:result].to_sym
    @created_at = time_check(info_hash[:created_at])
    @updated_at = time_check(info_hash[:updated_at])
  end

  def time_check(time)
    if time.class == Time
      time
    else
      Time.parse(time)
    end
  end
end
