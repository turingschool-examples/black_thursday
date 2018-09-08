require 'pry'
require 'csv'

class CSVParse

  attr_reader :path

  def initialize(path)
    @path = path
  end

  def create_repo
    csv = parse
    # RENAME THIS
    # headers = csv.shift
    headers, *data = csv
    repo = hashed_rows(data, headers)
    return repo
  end


  def parse  # CEO method
    csv = CSV.read(@path)
    # hashed_rows(csv, headers)
    # CSV is mutated, no header
  end


  def hashed_rows(csv, headers)
    # head, *tail = headers
    temp = template_hash(headers)
    hash = {}
    csv.each { |row|
      key = row[0].to_sym
      hash[key] = fill_row(row, temp.dup)
    }
    return hash
  end


  def fill_row(row, template)
    head, *tail = row # head is ID, do not need
    keys = template.keys
    tail.each.with_index { |col, index|
      key = keys[index]
      template[key] = tail[index]
    }
    return template
  end


  def template_hash(headers)
    headers.shift
    # headers mutated
    hash = {}
    headers.each { |col|
      key = col.to_sym
      hash[key] = ""
    }
    return hash
  end












end
