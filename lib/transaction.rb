require_relative 'repository/record'


class Transaction < Repository::Record

  attr_reader :invoice_id, :credit_card_number, :credit_card_expiration_date, :result
  def initialize(repo, fields)
    super(repo, fields)
    @invoice_id =                   fields[:invoice_id].to_i
    @credit_card_number =           fields[:credit_card_number].to_i
    @credit_card_expiration_date =  fields[:credit_card_expiration_date]
    @result =                       fields[:result]
  end

end
