class MockData

  def self.get_mock_merchants(number_of_mocks)
    mocked_merchants = []
    number_of_mocks.times do |merchant_number|
      merchant = {}
      merchant[:name] = "Merchant #{merchant_number}"
      merchant[:id] = merchant_number
      mocked_merchants << merchant
    end
    mocked_merchants
  end
end
