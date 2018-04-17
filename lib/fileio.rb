# frozen_string_literal: true

require 'csv'
# reads from given csv path
class FileIo
  def self.load(path)
    CSV.open path, headers: true, header_converters: :symbol
  end
end
