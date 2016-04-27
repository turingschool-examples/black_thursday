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
      :created_at  => "2009-02-07",
      :updated_at  => "2014-03-15"
    }),

    ({
      :id          => 7,
      :customer_id => 8,
      :merchant_id => 9,
      :status      => "shipped",
      :created_at  => "2012-11-23",
      :updated_at  => "2013-04-14"
    }),

    ({  :id          => 9,
      :customer_id => 8,
      :merchant_id => 11,
      :status      => "returned",
      :created_at  => "2000-03-04",
      :updated_at  => "2016-11-18"
    })
  ]
  end

  def transactions
    [
      ({
        :id => 6,
        :invoice_id => 8,
        :credit_card_number => 4242424242424242,
        :credit_card_expiration_date => "0220",
        :result => "success",
        :created_at => "2012-02-26 23:56:56 UTC",
        :updated_at => "2012-02-27 00:56:56 UTC"
        }),

        ({
          :id => 7,
          :invoice_id => 10,
          :credit_card_number => 1111111111111111,
          :credit_card_expiration_date => "0321",
          :result => "success",
          :created_at => "2012-02-26 20:56:56 UTC",
          :updated_at => "2012-02-26 20:56:56 UTC"
        }),

        ({
          :id => 13,
          :invoice_id => 10,
          :credit_card_number => 6666666666666666,
          :credit_card_expiration_date => "0622",
          :result => "failed",
          :created_at => "2012-02-26 20:56:57 UTC",
          :updated_at => "2012-02-26 20:56:57 UTC"
        })
      ]
  end

  def customers
    [
      ({ :id => 6,
        :first_name => "Joan",
        :last_name  => "Clarke",
        :created_at  => "2012-12-18 14:54:09 UTC",
        :updated_at => "2012-03-27 14:54:09 UTC"
      }),

      ({ :id => 8,
         :first_name => "Jenny",
         :last_name  => "Soden",
         :created_at => "2000-03-04 08:14:06 UTC",
         :updated_at => "2016-04-23 18:37:09 UTC"
      }),

     ({ :id => 10,
        :first_name => "Anna",
        :last_name  => "Weisbrodt",
        :created_at => "2001-04-05 14:04:09 UTC",
        :updated_at => "2016-04-23 04:54:49 UTC"
      })
    ]
  end

  def invoice_items
    [(
      { :id => "1",
      :item_id => "263519844",
      :invoice_id => "1",
      :quantity => "5",
      :unit_price => BigDecimal.new(13.63, 4),
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"
    }),

      ({ :id => "2",
        :item_id => "263454779",
        :invoice_id => "1",
        :quantity => "9",
        :unit_price => BigDecimal.new(13.63, 4),
        :created_at => "2012-03-27 14:54:09 UTC",
        :updated_at => "2012-03-27 14:54:09 UTC"
      }
    )]
  end

end
