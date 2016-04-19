require 'simplecov'
SimpleCov.start
require './lib/item'


class TestHelper


  def items
    [
      Item.new({
      :id          => 263410303,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99, 4),
      :merchant_id => 12334261,
      :created_at  => "2016-04-19 09:04:25 -0600",
      :updated_at  => "2016-04-19 09:04:25 -0600"
      }),

      Item.new({
        :id          => 123456789,
        :name        => "Pen",
        :description => "You can use it to also write things",
        :unit_price  => BigDecimal.new(9.99, 3),
        :merchant_id => 12345678,
        :created_at  => "2016-05-19 09:10:25 -0600",
        :updated_at  => "2016-05-19 09:04:25 -0600"
      }),

      Item.new({
        :id          => 132457689,
        :name        => "Paper",
        :description => "You can use it to write things on",
        :unit_price  => BigDecimal.new(14.99,4),
        :merchant_id => 10293845,
        :created_at  => "2016-04-19 10:04:25 -0600",
        :updated_at  => "2016-04-19 11:04:25 -0600"
      }),

      Item.new({
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

end
