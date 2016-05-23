User.seed(
  { id: 1, email: 'jironbach@gmail.com', password: 'bizit51japan', password_confirmation: 'bizit51japan', admin: true, confirmed_at: Time.now },
  { id: 2, email: 'bizitjapan@gmail.com', password: 'bizit55japan', password_confirmation: 'bizit55japan', admin: true, confirmed_at: Time.now },
)
