class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at
              
  def initialize(info, repo)
    @id         = info[:id].to_i
    @invoice_id = info[:invoice_id].to_i
    @credit_card_number = info[:credit_card_number]
    @credit_card_expiration_date = info[:credit_card_expiration_date]
    @result     = info[:result].to_sym
    @created_at = Time.parse(info[:created_at])
    @updated_at = Time.parse(info[:updated_at])
    @repo       = repo
  end

  def update(attributes)
    (@credit_card_number = attributes[:credit_card_number]) if !attributes[:credit_card_number].nil?
    (@credit_card_expiration_date = attributes[:credit_card_expiration_date]) if !attributes[:credit_card_expiration_date].nil?
    (@result = attributes[:result]) if !attributes[:result].nil?
    @updated_at = Time.now
  end
end