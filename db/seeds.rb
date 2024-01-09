# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# 5人のユーザーを作成
5.times do |n|
  user = User.create(
    name: "user#{n+1}", # ユーザー名を設定 ("user1" から "user5")
    email: "test#{n+1}@test.com", # ユーザーのメールアドレスを設定
    password: "123456", # パスワードを一律で設定
  )
  if user.valid?
    puts "User #{n+1} created" # ユーザーの作成をコンソールに出力
  else
    puts "Error creating user #{n+1}: #{user.errors.full_messages.join(', ')}" # エラー表示
  end
end

# それぞれのユーザーに対して、5つの本を作成
User.all.each do |user|
  3.times do |n|
    book = Book.create(
      title: "本#{n+1}", # 本のタイトルを設定
      body: "サンプル投稿です#{n+1}", # 本の本文を設定
      user_id: user.id,  # 本をユーザーに関連付け
      created_at: Time.current - rand(10).day # 本の作成日時を設定（過去10日間からランダムに選択）
    )
    if book.valid?
      puts "Book for User #{user.id} created" # 本の作成をコンソールに出力
    else
      puts "Error creating book for User #{user.id}: #{book.errors.full_messages.join(', ')}" # エラー表示
    end
  end
end
