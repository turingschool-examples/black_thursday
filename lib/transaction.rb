require_relative 'repository/record'


class Transaction < Repository::Record

  attr_reader :item_id, :invoice_id, :quantity, :unit_price
  def initialize(repo, fields)
    super(repo, fields)
    @invoice_id =                   fields[:invoice_id].to_i
    @credit_card_number =           fields[:credit_card_number]
    @credit_card_expiration_date =  fields[:credit_card_expiration_date]
    @result =                       fields[:result]
  end

end
