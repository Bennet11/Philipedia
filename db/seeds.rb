User.destroy_all
Wiki.destroy_all

5.times do
  User.create!(
    email: Faker::Internet.email,
    password: Faker::Internet.password,
    confirmed_at: Time.now
  )
end

10.times do
  Wiki.create!(
    title: Faker::Book.title,
    body: Faker::Lorem.paragraph(4),
    private: false
  )
end
