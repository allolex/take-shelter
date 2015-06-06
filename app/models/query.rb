class Query < ActiveRecord::Base
  belongs_to :caller

  after_initialize :set_all_attributes

  validates_presence_of :body

  private

  def set_all_attributes

  end


end
