require 'pry'

class Merchant
  attr_reader   :id
  attr_accessor :name


  def initialize(hash)
    @id   = hash[:id].to_i
    @name = hash[:name]
  end

end
<<<<<<< HEAD

=======
>>>>>>> 5f399fe8d79407e1d5933ab68e0dfa355e65e7b2
