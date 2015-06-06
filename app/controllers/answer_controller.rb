class AnswerController < ApplicationController
  def query
    render plain: "OK"
  end

  def message
    twiml = Twilio::TwiML::Response.new do |r|
      r.Message "Hello, thanks for the message."
    end
    render plain: twiml.text
  end
end
