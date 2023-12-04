# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb
puts 'Cleaning database...'
Teddy.destroy_all if Rails.env.development?
Category.destroy_all if Rails.env.development?

puts 'Creating categories...'
geek = Category.create!(name: 'geek')
kids = Category.create!(name: 'kids')

puts 'Creating teddies...'
Teddy.create!(price: 10, sku: 'original-teddy-bear', name: 'Teddy bear', category: kids, photo_url: 'https://res.cloudinary.com/dpubgcilc/image/upload/v1701637578/Best-Choice-Products-38in-Giant-Soft-Plush-Teddy-Bear-Stuffed-Animal-Toy-w-Bow-Tie-Footprints-Brown_683488a1-eff8-4a0e-b076-9bb782a16c14.60bbfc5d285269f3a12eeb9c85dae585_pjd1al.webp')
Teddy.create!(price_cents: 950, sku: 'jean-mimi', name: 'Jean-Michel - Le Wagon', category: geek, photo_url: 'https://pbs.twimg.com/media/B_AUcKeU4AE6ZcG.jpg:large')
Teddy.create!(price: 7, sku: 'octocat', name: 'Octocat -  GitHub',      category: geek, photo_url: 'https://cdn-ak.f.st-hatena.com/images/fotolife/s/suzumidokoro/20160413/20160413220730.jpg')
puts 'Finished!'
