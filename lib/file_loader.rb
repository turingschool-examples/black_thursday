# frozen_string_literal: true

require 'csv'
# This module is strictly to load in the CSV files which allow the lists to be
# populated. We turn on headers to store the first row as the headers and
# convert those headers into symbols to be referenced later.
module FileLoader
  def load_file(file_name)
    CSV.open file_name, headers: true, header_converters: :symbol
  end
end
