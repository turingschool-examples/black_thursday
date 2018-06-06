# frozen_string_literal: false

require 'csv'
# reads in csv files
module FileReader
  def self.load(path)
    CSV.read(path, headers: true, header_converters: :symbol)
  end
end
