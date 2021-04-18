require 'rspec'
require 'csv'
require './lib/file_io'
require './lib/customer_repository'

describe CustomerRepository do
  describe '#initialize' do
    it 'exists' do
      