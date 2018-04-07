require 'csv'
class ItemRepository

  def from_csv(csv)

    rows = []
    csv = CSV.read(csv, headers: true)
    # do |row|
    count = csv.count
    elements = (1..count).to_a.map do |index|
      csv[index].to_h
    end
    #   rows << row[0].split("\t")
    # end
    # rows[1]
    # # CSV.read(csv, :quote_char => "|")
  end


end
