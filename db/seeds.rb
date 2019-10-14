require 'csv'

MEDIA_FILE = Rails.root.join('db', 'seed_data', 'media-seeds.csv')
puts "Loading raw media data from #{MEDIA_FILE}"

media_failures = []
CSV.foreach(MEDIA_FILE, :headers => true) do |row|
  media = Media.new
  media.title = row['title']
  media.category = row['category']
  media.create = row['creator']
  media.publication_year = row['publication_year']
  media.description = row['description']
  successful = media.save
  
  if !successful
    media_failures << media
    puts "Failed to save media: #{media.inspect}"
  else
    puts "Created media: #{media.inspect}"
  end
end

puts "Added #{Media.count} media records"
puts "#{media_failures.length} medias failed to save"



USER_FILE = Rails.root.join('db', 'seed_data', 'user-seeds.csv')
puts "Loading raw user data from #{USER_FILE}"

user_failures = []
CSV.foreach(USER_FILE, :headers => true) do |row|
  user = User.new
  user.name = row['name']
  user.join_date = row['join_date']
  successful = user.save
  if !successful
    user_failures << user
    puts "Failed to save user: #{user.inspect}"
  else
    puts "Created user: #{user.inspect}"
  end
end

puts "Added #{User.count} user records"
puts "#{user_failures.length} users failed to save"

# Since we set the primary key (the ID) manually on each of the
# tables, we've got to tell postgres to reload the latest ID
# values. Otherwise when we create a new record it will try
# to start at ID 1, which will be a conflict.
puts "Manually resetting PK sequence on each table"
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

puts "done"
