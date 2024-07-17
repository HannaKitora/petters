class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @user = current_user
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
