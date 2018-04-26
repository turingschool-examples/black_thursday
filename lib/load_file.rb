# frozen_string_literal: true

require 'csv'
# loads in CSV file
class LoadFile
  def self.load(file_name)
    CSV.open file_name, headers: true, header_converters: :symbol
  end
end
