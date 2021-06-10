require_relative './spec_helper'


RSpec.describe TransactionRepository do
  describe 'instantiation' do
    before :each do
      @se = SalesEngine.from_csv({
        items: 'spec/fixtures/items.csv',
        merchants: 'spec/fixtures/merchants.csv',
        invoices: 'spec/fixtures/invoices.csv',
        customers: 'spec/fixtures/customers.csv',
        invoice_items: 'spec/fixtures/invoice_items.csv',
        transactions: 'spec/fixtures/transactions.csv'
        })
        @tr = TransactionRepository.new('spec/fixtures/transactions.csv', @se)
        @transaction1 = @tr.all[0]
        @transaction2 = @tr.all[1]
        @transaction3 = @tr.all[2]
        @transaction4 = @tr.all[3]
        @transaction5 = @tr.all[4]
        @transaction6 = @tr.all[5]
        @transaction7 = @tr.all[6]
        @transaction8 = @tr.all[7]
        @transaction9 = @tr.all[8]
        @transaction10 = @tr.all[9]
        @transaction11 = @tr.all[10]
        @transaction12 = @tr.all[11]
        @transaction13 = @tr.all[12]
        @transaction14 = @tr.all[13]
        @transaction15 = @tr.all[14]
        @transaction16 = @tr.all[15]
        @transaction17 = @tr.all[16]
        @transaction18 = @tr.all[17]
        @transaction19 = @tr.all[18]
        @transaction20 = @tr.all[19]
      end

      it 'exists' do

        expect(@tr).to be_a(TransactionRepository)
      end

      it "generates TransactionRepository " do
        expect(@transaction1.id).to eq(1)
        expect(@transaction1.invoice_id).to eq(1)
        expect(@transaction1.credit_card_number).to eq('4068631943231473')
        expect(@transaction1.credit_card_expiration_date).to eq('0217')
        expect(@transaction1.result).to eq(:success)
      end

      it 'finds transaction by id or return nil' do
        expect(@tr.find_by_id(1)).to eq(@transaction1)
        expect(@tr.find_by_id(2)).to eq(@transaction2)
        expect(@tr.find_by_id(1000000)).to eq(nil)
      end

      it 'finds all invoice_id or return []' do
        expect(@tr.find_all_by_invoice_id(1)).to eq([@transaction1])
        expect(@tr.find_all_by_invoice_id(2)).to eq([@transaction2])
        expect(@tr.find_all_by_invoice_id(1000000)).to eq([])
      end

      it 'finds all by credit card number or return []' do
        expect(@tr.find_all_by_credit_card_number('4068631943231473')).to eq([@transaction1])
        expect(@tr.find_all_by_credit_card_number('4177816490204479')).to eq([@transaction2])
        expect(@tr.find_all_by_credit_card_number('1000000000000000')).to eq([])
      end

      it 'finds all invoice_id or return []' do
        expected = [
          @transaction1,
          @transaction2,
          @transaction3,
          @transaction4,
          @transaction5,
          @transaction6,
          @transaction7,
          @transaction8,
          @transaction10,
          @transaction11,
          @transaction12,
          @transaction13,
          @transaction15,
          @transaction16,
          @transaction17,
          @transaction19,
          @transaction20
        ]
        expect(@tr.find_all_by_result(:success)).to eq(expected)
        expect(@tr.find_all_by_result(:failed)).to eq([@transaction9, @transaction14, @transaction18])
        expect(@tr.find_all_by_result(:football)).to eq([])
      end

      it 'creates new transaction instance with given attributes' do
        attributes = {
          id:         21,
          invoice_id: 21,
          credit_card_number: '20000000000000000',
          credit_card_expiration_date: '0922',
          result: :success,
          created_at: Time.now,
          updated_at: Time.now
        }

        @tr.create(attributes)
        new_transaction = @tr.all.last
        expect(new_transaction.id).to eq(21)
        expect(@tr.all.length).to eq(21)
        expect(new_transaction.credit_card_number).to eq('20000000000000000')
        expect(@tr.find_by_id(21).invoice_id).to eq(21)
        @tr.create(attributes)
        newer_transaction = @tr.all.last
        expect(newer_transaction.id).to eq(22)
      end

      it 'updates transaction by quantity and unit_price with given id' do
        new_transaction = { credit_card_number: '20000000000000000',
                            credit_card_expiration_date: '0922',
                            result: :failed
                          }
        prev_updated_at = @transaction1.updated_at
        @tr.update(1, new_transaction)

        expect(@transaction1.credit_card_number).to eq('20000000000000000')
        expect(@transaction1.credit_card_expiration_date).to eq('0922')
        expect(@transaction1.result).to eq(:failed)
        expect(prev_updated_at).to_not eq(@transaction1.updated_at)
      end

      it 'delete invoice by id' do
        expect(@tr.all.length).to eq(20)
        expect(@tr.delete(1)).to eq(@transaction1)
        expect(@tr.all.length).to eq(19)
      end
    end
  end
