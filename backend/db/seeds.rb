# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# TAG
100.times do |n|
  Tag.create!(
    name: "tag#{n}",
    status: 1,
    description: "description#{n}",
  )
end

# トランザクション
ActiveRecord::Base.transaction do
  
  # ユーザー
  10.times do |n|
    user = User.create!(
      name: "user#{n}",
      email: "user#{n}@example",
      password_digest: "password",
      status: 1
    )
    
    # Article
    100.times do |m|
      article = Article.create!(
        title: "title#{m}",
        content: "content#{m}",
        status: 1,
        user_id: user.id
      )
  
      article.comments.create!(
        content: "comment#{m}",
        user_id: User.last.id
      )
  
      article.article_tags.create!(
        tag_id: Tag.last.id
      )

  
    end
  end


end
