require 'pry'

require_relative 'data_typing'

class Merchant
  include DataTyping

  attr_reader   :id, :created_at
  attr_accessor :name, :updated_at

  def initialize(hash)
    # -- Read Only --
    @id   = make_integer(hash[:id])
    @created_at = make_time(hash[:created_at]) if hash[:created_at]
    # -- Accessible --
    @name = hash[:name]
    @updated_at = make_time(hash[:updated_at]) if hash[:updated_at]
  end

  def make_update(hash)
    @name = hash[:name]                         if hash[:name]
    @updated_at  = make_time(hash[:updated_at]) if hash[:updated_at]
    @updated_at  = make_time(Time.now)          if hash[:updated_at] == nil
  end


end
