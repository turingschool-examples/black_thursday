class Transaction
  attr_reader :trans

  def initialize(trans, trans_repo)
    @trans = trans
    @trans_repo = trans_repo
  end

  def id
    trans.fetch(:id).to_i
  end

  def invoice_id
    trans.fetch(:invoice_id).to_i
  end

  def credit_card_number
    trans.fetch(:credit_card_number).to_i
  end

  def credit_card_expiration_date
    trans.fetch(:credit_card_expiration_date)
  end

  def result
    trans.fetch(:result)
  end

  def created_at
    Time.parse(trans.fetch(:created_at))
  end

  def updated_at
    Time.parse(trans.fetch(:updated_at))
  end
end
