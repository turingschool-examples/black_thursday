class Cleaner
  attr_accessor :contents

  def initialize
    @file = "/Users/alexamsmyth/turing/1mod/projects/black_thursday/data/merchants.csv"
    @contents = CSV.open(@file, headers: true, header_converters: :symbol)
  end

  def clean_id(id)
    id.to_i
  end

end
