class App
  TYPES = {
    year: Time.now.strftime("%Y"),
    month: Time.now.strftime("%m"),
    day: Time.now.strftime("%d"),
    hour: Time.now.strftime("%H"),
    minute: Time.now.strftime("%M"),
    second: Time.now.strftime("%S")
  }.freeze

  TimeFormat = Struct.new(:request) do
    
    def valid?
      request.params['format'].split(',').all? { |type| TYPES[type.to_sym] } && request.path == '/time'
    end

    def unkonown_formats
      unkonown_formats = request.params['format'].split(',').map {|a| a unless TYPES[a.to_sym]}
      unkonown_formats.compact!
    end
    
    def time
      time = request.params['format'].split(',').map { |a| TYPES[a.to_sym] }
      time.join('-')
    end

  end
  
  def call(env)
    time_format = TimeFormat.new(Rack::Request.new(env))

    if time_format.valid?
      [200, headers, [time_format.time]]
    elsif time_format.unkonown_formats.any?
      [400, headers, ['Unknown time format ', time_format.unkonown_formats.to_s]]
    else
      [404, {}, []]
    end

  end

  private

  def headers
    { 'Content-Type' => 'text/plain' }
  end

end