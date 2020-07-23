class TimelineChannel < ApplicationCable::Channel
  def subscribed
    stream_from "timeline-stream"
  end
end
