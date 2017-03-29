class Event < ActiveRecord::Base
  belongs_to :project
  validates_presence_of :project_id

  EVENT_TYPE_PHRASES = {'signup' => 'signed up', 'upgraded' => 'upgraded', 'purchase' => 'purchased', 'subscribe' =>'subscribed'}

  def message
    if self.project.custom_message? && self.variables?
      msg = custom_message
    else
      msg = "Someone just #{event_type_phrase}"
    end

    "#{msg} for #{self.project.name} <small>#{time_ago}</small>"
  end

  def time_ago
    timestamp = ((DateTime.current.utc - self.created_at) / 60).round

    if timestamp < 1
      return "#{timestamp} seconds ago"
    elsif timestamp.between?(1, 60)
      return "#{timestamp} minutes ago"
    elsif timestamp.between?(60, 1440)
      return "#{(timestamp / 60)} hours ago"
    else
      days_ago = (timestamp / 60 / 60)
      return "1 day ago" if days_ago == 1
      return "#{(timestamp / 60 / 60)} days ago"
    end
  end

  def event_type_phrase
    EVENT_TYPE_PHRASES[self.event_type]
  end

  def custom_message
    msg = self.project.custom_message

    # event type phrase
    msg = msg.gsub( /{{(\s|\w)?(event_type)(\s|\w)?}}/, event_type_phrase)

    # custom vars
    variables.each do |variable, value|
      msg = msg.gsub( /{{(\s|\w)?(#{variable})(\s|\w)?}}/, value)
    end

    msg
  end

  # TODO: delete
  def sample_event_post
    params = {event: {'event_type': 'signup', 'variables' => {'city' => 'san francisco', 'something-unused' => 'hahah'}}}

    resp = Curl.post("https://cca7bf1b.ngrok.io/api/v1/projects/5509cfac62e0c6bcd724/events", params.to_json) do |http|
      http.headers['Content-Type'] = 'application/json'
    end
  end

end
