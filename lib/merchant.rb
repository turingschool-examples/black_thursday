require 'pry'

class Merchant

  attr_reader :name,
              :id

  def initialize(params = {}, parent = nil)
    @parent = parent
    @name = params['name']
    @id   = params['id'].to_i
  end

  def items
    @parent.mid_to_se(self.id)
  end
end
