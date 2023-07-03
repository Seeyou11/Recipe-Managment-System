  # This file should contain all the record creation needed to seed the database with its default values.
  # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
  #
  # Examples:
  #
  #   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
  #   Character.create(name: "Luke", movie: movies.first)
  # seeds.rb

  # Create users
  # Create users if they don't exist
  user1 = User.find_or_create_by(username: "user1", email: "user1@example.com") do |user|
    user.password = "password1"
    user.password_confirmation = "password1"
    user.admin = true
  end

  user2 = User.find_or_create_by(username: "user2", email: "user2@example.com") do |user|
    user.password = "password2"
    user.password_confirmation = "password2"
  end

  user1.file.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'sergio.jpg')), filename: 'sergio.jpg')
  user2.file.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'sergio.jpg')), filename: 'sergio.jpg')

  # Create categories
  category1 = Category.create!(
    name: "Category 3",
    description: "This is category 1",
    user_id: user1.id
  )

  category2 = Category.create!(
    name: "Category 4",
    description: "This is category 2",
    user_id: user2.id
  )

  # Create recipes
  recipe1 = Recipe.create!(
    title: "Recipe 1",
    description: "This is recipe 1",
    preparation_steps: "Step 1, Step 2, Step 3",
    user_id: user1.id,
    category_id: category1.id
  )

  recipe2 = Recipe.create!(
    title: "Recipe 2",
    description: "This is recipe 2",
    preparation_steps: "Step 1, Step 2, Step 3",
    user_id: user2.id,
    category_id: category2.id
  )


  # Attach a file to the recipe's image
  recipe1.file.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'pizza.jpg')), filename: 'pizza.jpg')
  recipe2.file.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'sheri.jpg')), filename: 'sheri.jpg')

  # Create favorites
  Favorite.create!(recipe_id: recipe1.id, user_id: user1.id, value: 5)
  Favorite.create!(recipe_id: recipe2.id, user_id: user2.id, value: 4)

  # Create ratings
  Rating.create!(value: 4, recipe_id: recipe1.id, user_id: user1.id)
  Rating.create!(value: 5, recipe_id: recipe2.id, user_id: user2.id)

  # Create comments
  Comment.create!(
    content: "This is the first comment.",
    recipe_id: recipe1.id, 
    user_id: user1.id
  )

  Comment.create!(
    content: "This is the second comment.",
    recipe_id: recipe2.id, 
    user_id: user2.id
  )
