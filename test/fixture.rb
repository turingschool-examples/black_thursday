module Fixture
  class << self

    def sales_engine
      SalesEngine.new({
        merchants: merchant_data,
        items: item_data
      })
    end

    def repo type
      sales_engine.repo(type)
    end

    def merchant_data
      [
        {
          name: "merchant 1",
          id: "1"
        },{
          name: "merchant 2",
          id: "2"
        },{
          name: "merchant 3",
          id: "3"
        },{
          name: "merchant 4",
          id: "4"
        },{
          name: "merchant 5",
          id: "5"
        },{
          name: "'chant 6",
          id: "6"
        }
      ]
    end

    def item_data
      [{
        id: "1",
        name: 'Apple',
        description: "One apple (a fruit, not a computer)",
        unit_price: "100",
        merchant_id: "1"
      },{
        id: "2",
        name: 'Banana',
        description: "One banana (a fruit, not a clip)",
        unit_price: "050",
        merchant_id: "2"
      },{
        id: "3",
        name: 'Cherry',
        description: "One cherry (a fruit, not a wood)",
        unit_price: "450",
        merchant_id: "2"
      },{
        id: "4",
        name: 'Durian',
        description: "A sweet thing with seeds",
        unit_price: "100",
        merchant_id: "3"
      }]
    end

    def invoice_data
      [
        {
          id: 1,
          customer_id: "1",
          merhcant_id: "1",
          status: "pending",
          created_at: '2014-03-15',
          updated_at:
        }
      ]
    end
  end
end
