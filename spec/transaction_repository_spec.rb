require './lib/transaction'
require'./lib/transaction_repository'

RSpec.describe TransactionRepository do
  let(:transaction_repository) {TransactionRepository.new}
  let(:transaction) {Transaction.new({
    :id => 6, 
    :invoice_id => 8,
    :credit_card_number => "4242424242424242",
    :credit_card_expiration_date  => "0220",
    :result => "success",
    :created_at => Time.now,
    :updated_at => Time.now
  })}

  it 'exists' do
    expect(transaction_repository).to be_a(TransactionRepository)
  end

  it "#find_all_by_invoice_id returns all transactions matching the given id" do
    transaction_repository.all << transaction

    expect(transaction_repository.find_all_by_invoice_id(5)).to eq []
    expect(transaction_repository.find_all_by_invoice_id(8)).to eq [transaction]
  end

  it "#find_all_by_credit_card_number returns all transactions matching given credit card number" do
    transaction_repository.all << transaction

    expect(transaction_repository.find_all_by_credit_card_number("4242424242423333")).to eq []
    expect(transaction_repository.find_all_by_credit_card_number("4242424242424242")).to eq [transaction]
  end

  it "#find_all_by_result returns all transactions matching given result" do
    transaction_repository.all << transaction

    expect(transaction_repository.find_all_by_result("failed")).to eq []
    expect(transaction_repository.find_all_by_result("success")).to eq [transaction]
  end

  it "#create creates a new transaction instance" do
    transaction_repository.all << transaction
    transaction_repository.create({ :id => 6, 
                                    :invoice_id => 8,
                                    :credit_card_number => "4242424242424000",
                                    :credit_card_expiration_date  => "0230",
                                    :result => "success",
                                    :created_at => Time.now,
                                    :updated_at => Time.now
                                  })

    expect(transaction_repository.all[1]).to be_a(Transaction)
    expect(transaction_repository.all[1].credit_card_number).to eq("4242424242424000")
    expect(transaction_repository.all[1].credit_card_expiration_date).to eq("0230")
    expect(transaction_repository.all[1].id).to eq(6)
  end

  it "#update updates a transaction" do
    transaction_repository.all << transaction
    transaction_repository.update(6, {:credit_card_number => "4242424242424000",
                                      :credit_card_expiration_date  => "0230"})

    expect(transaction_repository.all[0].credit_card_number).to eq("4242424242424000")
    expect(transaction_repository.all[0].credit_card_expiration_date).to eq("0230")
    expect(transaction_repository.all[0].id).to eq(6)
  end

  it "#update cannot update id, invoice_id, or created_at" do
    transaction_repository.all << transaction
    transaction_repository.update(6, {:id => 100,
                                      :invoice_id => 100,
                                      :created_at => Time.now })

    expect(transaction_repository.all[0].id).to eq(6)
    expect(transaction_repository.all[0].invoice_id).to eq(8)
  end

  it "#update on unknown transaction does nothing" do
    transaction_repository.all << transaction
    transaction_repository.update(8, {:credit_card_number => "4242424242424000",
                                    :credit_card_expiration_date  => "0230"})

    expect(transaction_repository.all[0].id).to eq(6)

    expect(transaction_repository.find_by_id(8)).to eq nil
  end
end