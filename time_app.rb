require_relative 'format_time'

class TimeApp
  
  def call(env)
    formatter = FormatTime.new(request: Rack::Request.new(env))

    [response_status(formatter), {}, response_body(formatter)]
  end

  private

  def response_status(formatter)
    if formatter.valid?
      200
    else
      400
    end
  end

  def response_body(formatter)
    if formatter.valid?
      formatter.time
    else
      formatter.invlaid_formats 
    end
  end

end
