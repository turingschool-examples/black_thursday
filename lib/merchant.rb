# frozen_string_literal: true

# This is the Merchant Class
class Merchant
  attr_reader :id,
              :name

  def initialize(data, repo)
    @id   = (data[:id]).to_i
    @name = data[:name]
    @merchant_repo = repo
  end

  def update(name)
    @name = name[:name]
  end
end
