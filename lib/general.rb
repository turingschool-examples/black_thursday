# frozen_string_literal: true

# this is the General superclass
class General
  attr_reader :id, :attribute

  def initialize(data, repo)
    @id = data[:id].to_i
    @attribute = data[:attribute]
    @general_repo = repo
  end

  def update(data)
    @attribute = data[:attribute]
  end
end
