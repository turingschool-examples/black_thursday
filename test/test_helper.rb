require 'simplecov'
SimpleCov.start
require './lib/item'


class TestHelper


  def items
    [
      Item.new({
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99, 4),
      :created_at  => "2016-04-19 09:04:25 -0600",
      :updated_at  => "2016-04-19 09:04:25 -0600",
      }),

      Item.new({
        :name        => "Pen",
        :description => "You can use it to also write things",
        :unit_price  => BigDecimal.new(9.99, 3),
        :created_at  => "2016-05-19 09:10:25 -0600",
        :updated_at  => "2016-05-19 09:04:25 -0600",
      }),

      Item.new({
        :name        => "Paper",
        :description => "You can use it to write things on",
        :unit_price  => BigDecimal.new(14.99,4),
        :created_at  => "2016-04-19 10:04:25 -0600",
        :updated_at  => "2016-04-19 11:04:25 -0600",
      })
    ]
  end

end
