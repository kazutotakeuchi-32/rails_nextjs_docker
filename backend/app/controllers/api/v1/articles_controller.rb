class Api::V1::ArticlesController < ApplicationController

    def index
        @articles = Article.all
        render json: @articles, include: [:comments, :article_tags]
    end

    def show
      @article = Article.find(params[:id])
      render json: @article, include: [:comments, :article_tags]
      # 404 Not Found
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Article not found", status: 403 }, status: :not_found
    end


    def timeline 
        user = User.first
        @articles = user.get_timeline
        
        render json: @articles, include: [comments: {include: :likes, include: :user}, likes: {include: :user}]
    end
end
