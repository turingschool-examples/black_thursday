require 'CSV'

module Parsable

  def parse_csv(path)
    parsed_csv = CSV.parse(File.read(path), headers: true, header_converters: :symbol).to_a
    headers = parsed_csv.shift
    repo = []
    parsed_csv.each do |data|
      new_hash = Hash.new
      counter = 0
      headers.each do |header|
        new_hash[header] = data[counter]
        counter += 1
      end
      repo << new_hash
    end
    repo
  end

end
