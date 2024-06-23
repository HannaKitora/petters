class SearchesController < ApplicationController
  before_action :authenticate_user!
  
  # def search
  #   @range = params[:range]

  #   if @range == "User"
  #     @users = User.looks(params[:search], params[:word])
  #   elsif @range == "Pet"
  #     @pets = Pet.looks(params[:search], params[:word])
  #   elsif @range == "Event"
  #     @events = Event.looks(params[:search], params[:word])
  #   end
  # end
  
  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    
    # 選択したモデルに応じて検索を実行
    if @model  == "user"
      @records = User.search_for(@content, @method)
    elsif @model  == "pet"
      @records = Pet.search_for(@content, @method)
    elsif @model == "event"
      @records = Event.search_for(@content, @method)
    end
  end
end
