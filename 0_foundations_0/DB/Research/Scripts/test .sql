

Ref:"Categories"."id" < "Categories"."CategoryID"

Ref:"Status"."id" < "Categories"."StatusID"

Ref:"UserProfile"."id" < "Categories"."AuthorID"

Ref:"UserProfile"."id" < "user_group"."user_id"

Ref:"Categories"."id" < "Guilds"."CategoryID"

Ref:"Status"."id" < "Posts"."StatusID"

Ref:"Threads"."id" < "Posts"."ThreadID"

Ref:"UserProfile"."id" < "Posts"."AuthorID"

Ref:"Status"."id" < "Threads"."StatusID"

Ref:"UserProfile"."id" < "Threads"."AuthorID"

Ref:"Guilds"."id" < "user_group"."groups_id"

Ref:"UserStatus"."id" < "UserProfile"."UserStatus"

Ref:"Posts"."id" < "Voting"."  PostID"

Ref:"Threads"."id" < "Voting"."ThreadID"