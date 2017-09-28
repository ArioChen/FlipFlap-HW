# Module that can be included (mixin) to take and output TSV data
module TsvBuddy
  # take_tsv: converts a String with TSV data into @data
  # parameter: tsv - a String in TSV format
  attr_accessor :data
  def take_tsv(tsv)
    ymal_lines = []
    lines = []
    tsv.each_line { |line| lines << line }
    keys = lines[0].split("\t")
    keys.map!(&:chomp)
    lines.shift
    lines.each do |line|
      values = line.split("\t")
      record = {}
      keys.each_index { |index| record[keys[index]] = values[index].chomp }
      ymal_lines.push(record)
    end
    @data = ymal_lines
  end
  
  # to_tsv: converts @data into tsv string
  # returns: String in TSV format
  def to_tsv
    tsv_string = ''
    heading = ''
    data = @data
    data[0].each_key { |key| heading << key + "\t" }
    tsv_string << heading.strip
    tsv_string << "\n"
    0.upto(data.length - 1) do |index|
      record = ''
      data[index].each_value { |val| record << val + "\t" }
      tsv_string << record.strip
      tsv_string << "\n"
    end
    tsv_string
  end
end
