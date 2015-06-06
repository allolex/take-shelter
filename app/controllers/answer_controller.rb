class AnswerController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_filter :parse_query
  before_filter :set_current_user

  after_filter :set_header

  def message
   twiml =  if shelter = Hurricaneshelter.by_zipcode(params["Body"])
              Twilio::TwiML::Response.new do |r|
                r.Message "Your nearest shelter is #{shelter}"
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

  def parse_query
    @query = Query.create(params)
  end

  def set_current_user
    @current_user = Caller.where(phone: @query.phone, language: @query.language).first_or_create
  end
end
