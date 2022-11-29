class FormatTime

  TYPES = {
    year: "%Y",
    month: "%m",
    day: "%d",
    hour: "%H",
    minute: "%M",
    second: "%S"
  }.freeze

  def initialize(format:)
    @format = format || ''
  end

  def valid?
    @format.split(',').all? { |type| TYPES[type.to_sym] }
  end

  def invlaid_formats
    unkonown_formats = @format.split(',').map {|a| a unless TYPES[a.to_sym]}
    unkonown_formats.compact!
  end
  
  def time
    time = @format.split(',').map { |a| TYPES[a.to_sym] }
    Time.now.strftime(time.join('-'))
  end

end
