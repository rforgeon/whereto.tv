# Create Posts
 5.times do
 # #1
   Post.create!(
 # #2
     title:  "San Francisco",
     body:   "San Francisco is the best place to visit! You should definitely go there."
   )
 end
 posts = Post.all

 # Create Comments
 # #3
 10.times do
   Comment.create!(
 # #4
     post: posts.sample,
     body: "I agree, it's a cool place."
   )
 end

 puts "Seed finished"
 puts "#{Post.count} posts created"
 puts "#{Comment.count} comments created"
