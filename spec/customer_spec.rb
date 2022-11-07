require_relative '../lib/customer'

RSpec.describe Customer do
  describe '#initiliaze' do
    it 'exists and has attributes' do
      c = Customer.new(
        :id => 6,
        :first_name => "Joan",
        :last_name => "Clarke",
        :created_at => created = Time.now.to_s,
        :updated_at => updated = Time.now.to_s
      )

      expect(c).to be_a(Customer)
      expect(c.id).to eq(6)
      expect(c.first_name).to eq("Joan")
      expect(c.last_name).to eq("Clarke")
      expect(c.created_at).to eq(Time.parse(created))
      expect(c.updated_at).to eq(Time.parse(updated))
    end
  end
end
