require 'time'

class Merchant
  attr_reader   :id,
                :created_at
  attr_accessor :name,
                :updated_at

  def initialize(information)
    @name = information[:name]
    @id = information[:id].to_i
    @created_at = if information[:created_at] == nil
                    Time.now
                  else
                    Time.parse(information[:created_at].to_s)
                  end 
    @updated_at = if information[:created_at] == nil
                    Time.now
                  else
                    Time.parse(information[:created_at].to_s)
                  end
  end
end
