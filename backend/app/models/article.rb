class Article < ApplicationRecord
  # 中間テーブルの設定
  has_many :article_tags, dependent: :destroy
  # 中間テーブルを通してtagsテーブルとの関連付け
  has_many :tags, through: :article_tags

  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  belongs_to :user
  
  
end
