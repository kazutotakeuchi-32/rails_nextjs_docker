class Api::V1::CommentsController < ApplicationController
  # GET /articles/:article_id/comments
  # 記事に紐づくコメントを取得
  def index 
    article = Article.includes(:likes,:user).find(params[:article_id])
    comments = article.comments
    render json: comments, include: [:likes, :user], status: :ok
    
    # 例外処理
    # 404 Not Found
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Article not found" }, status: :not_found
    # 401 Unauthorized
    # rescue JWT::DecodeError
    #   render json: { error: "You are not authorized to perform this action" }, status: :unauthorized
    # 400 Bad Request
    rescue ActionController::ParameterMissing => e
      render json: { error: e.message , status: 400 }, status: :bad_request
    # 500 Internal Server Error
    rescue StandardError => e
      render json: { error: e.message, status: 500 }, status: :internal_server_error
  end

  def show 
    comment = Comment.find(params[:id])
    render json: comment, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Comment not found" }, status: :not_found
    # rescue JWT::DecodeError
    #   render json: { error: "You are not authorized to perform this action" }, status: :unauthorized
    rescue ActionController::ParameterMissing => e
      render json: { error: e.message }, status: :bad_request
    rescue StandardError => e
      render json: { error: e.message }, status: :internal_server_error


  end

  def bad_like
    comment = Comment.find(params[:article_id])
    like = CommentLike.find_by(comment_id: comment, user_id: 3)
    if like
      like.destroy
    else
      CommentLike.create(comment_id: comment, user_id: 3, type: :bad_like)
    end
    render json: like, status: 201

    # 例外処理
    # 404 Not Found
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Comment not found" }, status: :not_found
    # 401 Unauthorized
    # rescue JWT::DecodeError
    #   render json: { error: "You are not authorized to perform this action" }, status: :unauthorized
    # 500 Internal Server Error
    rescue StandardError => e
      render json: { error: e.message }, status: :internal_server_error
  end


  # POST /comments/:id/good_like
  # グッドボタンを押した時の処理
  def good_like
    comment = Comment.find(params[:article_id])
    like = CommentLike.where(comment_id: comment.id, user_id: 3).first
    if like
      like.destroy
    else
      CommentLike.create(comment_id: comment.id, user_id: 3, type: 1)
    end
    render json: like, status: 201
    # 例外処理
    # 404 Not Found
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Comment not found" }, status: :not_found
    # 401 Unauthorized
    # rescue JWT::DecodeError
    #   render json: { error: "You are not authorized to perform this action" }, status: :unauthorized
    # 500 Internal Server Error
    rescue StandardError => e
      render json: { error: e.message, status: 500 }, status: :internal_server_error
  end
end



