class CalendarController < ApplicationController
  def index
    @evntries = Entry.all
  end
end
