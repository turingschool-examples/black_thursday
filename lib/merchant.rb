require 'pry'

class Merchant
  attr_reader :id
  attr_accessor :name


  def initialize(hash)
    @id = hash[:id]
    @name = hash[:name]
  end

end

# incoming raw hash from csv_parse
# hash = {:"12345" => {name: "Turing", created_at: "12-23-18"}}
# LOGIC HAPPENS
# stripped_hash = {:id => 5, :name => "Turing School"}
