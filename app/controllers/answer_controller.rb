class AnswerController < ApplicationController
  def query
    render plain: "OK"
  end

  def message
    twiml = Twilio::TwiML::Response.new do |r|
      r.Message I18n.t(:stay_with_friends, scope: :shelter)
    end
    render plain: twiml.text
  end
end
