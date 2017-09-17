it "merchant#customers returns related customers" do
  expected = engine.merchants.find_by_id(12334194).customers

  expect(expected.length).to eq 12
  expect(expected.first.class).to eq Customer
end

#iteration 3: this should be 13, I believe
