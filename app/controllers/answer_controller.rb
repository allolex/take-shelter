class AnswerController < ApplicationController
  skip_before_action :verify_authenticity_token

  after_filter :set_header

  def message
    twiml =  if shelter = Hurricaneshelter.by_zipcode(params["Body"]).first
              Twilio::TwiML::Response.new do |r|
                r.Message "Your nearest shelter is #{shelter.name} at #{shelter.address} / #{shelter.zipcode}"
              end
            else
              Twilio::TwiML::Response.new do |r|
                r.Message "Please send the zipcode of your location for the nearest shelter."
              end
            end
    render plain: twiml.text
  end

  private

  def set_header
    response.headers["Content-Type"] = "text/xml"
  end
end
