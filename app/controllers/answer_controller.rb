class AnswerController < ApplicationController
  skip_before_action :verify_authenticity_token

  after_filter :set_header

  def query
    render plain: "OK"
  end

  def message
    twiml = Twilio::TwiML::Response.new do |r|
      r.Message I18n.t(:stay_with_friends, scope: :shelter)
    end
    render plain: twiml.text
  end

  private

  def set_header
    response.headers["Content-Type"] = "text/xml"
  end
end
