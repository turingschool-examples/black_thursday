
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
    @id                          = data[:id].to_i
    @invoice_id                  = data[:invoice_id].to_i
    @credit_card_number          = data[:credit_card_number].to_i
    @credit_card_expiration_date = data[:credit_card_expiration_date]
    @result                      = data[:result]
    @created_at                  = date_convert(data[:created_at])
    @updated_at                  = date_convert(data[:updated_at])
    @parent                      = parent
  end

  def date_convert(from_file)
    date = from_file.split(/[-," ",:]/)
    time = Time.utc(date[0], date[1], date[2], date[3], date[4], date[5], date[6], date[7])
  end

  def invoice
    @parent.parent.invoices.find_by_id(invoice_id)
  end


end
