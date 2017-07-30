class Transaction

  attr_reader :id

  def initialize(transaction_info, transaction_repo)
    @id = transaction_info[:id].to_i
  end

end
