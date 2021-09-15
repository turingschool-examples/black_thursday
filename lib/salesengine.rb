require 'csv'


class SalesEngine
  attr_reader :items,
              :merchants

  def initialize(data)
    @items = data.fetch(:items)
    @merchants = data.fetch(:merchants)
  end

end
