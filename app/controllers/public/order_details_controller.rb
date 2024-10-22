class Public::OrderDetailsController < ApplicationController
  before_action :authenticate_user!
end
