class ActiveSupport::TimeWithZone
  def as_json(options = {})
    strftime('%A, %d %b %Y %l:%M %p')
  end
end