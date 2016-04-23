require 'simplecov'
SimpleCov.start
require './lib/item'


class TestHelper


  def items
    [
      ({
      :id          => 263410303,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99, 4),
      :merchant_id => 12334261,
      :created_at  => "2016-04-19 09:04:25 -0600",
      :updated_at  => "2016-04-19 09:04:25 -0600"
      }),

      ({
        :id          => 123456789,
        :name        => "Pen",
        :description => "You can use it to also write things",
        :unit_price  => BigDecimal.new(9.99, 3),
        :merchant_id => 12345678,
        :created_at  => "2016-05-19 09:10:25 -0600",
        :updated_at  => "2016-05-19 09:04:25 -0600"
      }),

      ({
        :id          => 132457689,
        :name        => "Paper",
        :description => "You can use it to write things on",
        :unit_price  => BigDecimal.new(14.99,4),
        :merchant_id => 10293845,
        :created_at  => "2016-04-19 10:04:25 -0600",
        :updated_at  => "2016-04-19 11:04:25 -0600"
      }),

      ({
        :id          => 132457688,
        :name        => "Stapler",
        :description => "You can use it to staple things together",
        :unit_price  => BigDecimal.new(9.99,4),
        :merchant_id => 12345678,
        :created_at  => "2016-04-19 10:04:25 -0600",
        :updated_at  => "2016-04-19 11:04:25 -0600"
      })
    ]
  end

  def invoices
    [
    ({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => 2009-02-07,
      :updated_at  => 2014-03-15
    }),
    ({
      :id          => 7,
      :customer_id => 8,
      :merchant_id => 9,
      :status      => "shipped",
      :created_at  => 2012-11-23,
      :updated_at  => 2013-04-14
    }),
    ({  :id          => 9,
      :customer_id => 8,
      :merchant_id => 11,
      :status      => "returned",
      :created_at  => 2000-03-04,
      :updated_at  => 2016-11-18
    }) ]

  end

end
