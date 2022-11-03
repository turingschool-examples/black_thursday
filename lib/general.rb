# frozen_string_literal: true

# this is the General superclass
class General
  attr_reader :id, :attribute

  def initialize(data)
    @id = data[:id]
    @attribute = data[:attribute]
  end

  def update(data)
    @attribute = data[:attribute]
  end
end
