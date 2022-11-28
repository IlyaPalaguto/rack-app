class FormatTime

  TYPES = {
    year: Time.now.strftime("%Y"),
    month: Time.now.strftime("%m"),
    day: Time.now.strftime("%d"),
    hour: Time.now.strftime("%H"),
    minute: Time.now.strftime("%M"),
    second: Time.now.strftime("%S")
  }.freeze

  def initialize(request:)
    @format = request.params['format']
  end

  def valid?
    @format.split(',').all? { |type| TYPES[type.to_sym] }
  end

  def invlaid_formats
    unkonown_formats = @format.split(',').map {|a| a unless TYPES[a.to_sym]}
    ['Unknown time format ', unkonown_formats.compact!.to_s]
  end
  
  def time
    time = @format.split(',').map { |a| TYPES[a.to_sym] }
    [time.join('-')]
  end

end
