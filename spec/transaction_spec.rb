require 'pry'
require 'rspec'
require 'simplecov'
require_relative '../lib/transaction'

SimpleCov.start

RSpec.describe Transaction do
  it 'exists' do
    t = Transaction.new({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
      })
      expect(t).to be_a(Transaction)
    end

    it 'can access id' do
      t = Transaction.new({
        :id => 6,
        :invoice_id => 8,
        :credit_card_number => "4242424242424242",
        :credit_card_expiration_date => "0220",
        :result => "success",
        :created_at => Time.now,
        :updated_at => Time.now
        })
        expect(t.id).to eq(6)
    end

    it 'can access invoice_id' do
      t = Transaction.new({
        :id => 6,
        :invoice_id => 8,
        :credit_card_number => "4242424242424242",
        :credit_card_expiration_date => "0220",
        :result => "success",
        :created_at => Time.now,
        :updated_at => Time.now
        })
        expect(t.invoice_id).to eq(8)
    end

    it 'can access credit_card_number' do
      t = Transaction.new({
        :id => 6,
        :invoice_id => 8,
        :credit_card_number => "4242424242424242",
        :credit_card_expiration_date => "0220",
        :result => "success",
        :created_at => Time.now,
        :updated_at => Time.now
        })
        expect(t.credit_card_number).to eq("4242424242424242")
    end

    xit 'can access credit_card_expiration_date' do
      t = Transaction.new({
        :id => 6,
        :invoice_id => 8,
        :credit_card_number => "4242424242424242",
        :credit_card_expiration_date => "0220",
        :result => "success",
        :created_at => Time.now,
        :updated_at => Time.now
        })
        expect(t.credit_card_expiration_date).to eq("0220")
    end

    xit 'can access result' do
      t = Transaction.new({
        :id => 6,
        :invoice_id => 8,
        :credit_card_number => "4242424242424242",
        :credit_card_expiration_date => "0220",
        :result => "success",
        :created_at => Time.now,
        :updated_at => Time.now
        })
        expect(t.result).to eq("success")
    end

    xit 'can access created_at' do
      t = Transaction.new({
        :id => 6,
        :invoice_id => 8,
        :credit_card_number => "4242424242424242",
        :credit_card_expiration_date => "0220",
        :result => "success",
        :created_at => Time.now,
        :updated_at => Time.now
        })
        expect(t.created_at).to eq(Time.now)
    end

    xit 'can access updated_at' do
      t = Transaction.new({
        :id => 6,
        :invoice_id => 8,
        :credit_card_number => "4242424242424242",
        :credit_card_expiration_date => "0220",
        :result => "success",
        :created_at => Time.now,
        :updated_at => Time.now
        })
        expect(t.updated_at).to eq(Time.now)
    end
  end
