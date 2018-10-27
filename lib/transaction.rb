class Transaction
  attr_reader :id #still need to add rest of things here

  def initialize(info)
    @id = info[:id]
    # still need to add remainder here
    # added ID to get rid of annoying error
  end

# Transaction.new({:id => row[0].to_i, :invoice_id => row[1],
#               :credit_card_number => row[2], :credit_card_expiration => row[3],
#               :result => row[4],
#               :created_at => Time.parse(row[5]),:updated_at=> Time.parse(row[6])})

end
