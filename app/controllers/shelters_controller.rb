class SheltersController < ApplicationController
  def index
    if params[:zip]
      @shelters = Hurricaneshelter.by_zipcode(params[:zip]).limit 5
    else
      @shelters = []
    end
  end
end
