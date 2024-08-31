class CalendarController < ApplicationController
  def index
    @calender = Calender.all
  end
end
