CREATE TABLE [users] (
  [UserID] int PRIMARY KEY IDENTITY(1, 1),
  [UserProfileID] int,
  [EmailAddress] nvarchar(255),
  [Password] nvarchar(255),
  [PasswordHash] nvarchar(255)
)
GO

CREATE TABLE [UserProfile] (
  [UserProfileID] int UNIQUE PRIMARY KEY,
  [FirstName] nvarchar(255),
  [LastName] nvarchar(255),
  [MiddleName] nvarchar(255),
  [IsActive] bool,
  [IsBlocked] bool,
  [Gender] nvarchar(255),
  [DateOfBirth] nvarchar(255),
  [Occupation] nvarchar(255),
  [Location] nvarchar(255),
  [About] nvarchar(255),
  [ProfileImage] nvarchar(255),
  [Following] nvarchar(255),
  [Followers] nvarchar(255),
  [PostLikes] nvarchar(255),
  [Activities] nvarchar(255),
  [Interests] nvarchar(255),
  [DateCreated] datetime,
  [UserType] nvarchar(255),
  [UserStatus] nvarchar(255),
  [StatusID] int,
  [UserProfileLink] nvarchar(255),
  [LastLogin] datetime
)
GO

CREATE TABLE [UserFollowers] (
  [UserFollowID] int PRIMARY KEY,
  [SourceID] int,
  [TargetID] int,
  [DateCreated] datetime
)
GO

CREATE TABLE [ContactConnections] (
  [ContactConnectionID] int PRIMARY KEY,
  [ConnectorID] int,
  [ConnectID] int,
  [DateCreated] datetime
)
GO

CREATE TABLE [BlockedList] (
  [BlockID] int PRIMARY KEY,
  [BlockerID] int,
  [BlockeeID] int,
  [DateCreated] datetime
)
GO

CREATE TABLE [GuildFollowers] (
  [GuildFollowID] int PRIMARY KEY,
  [SourceID] nvarchar(255),
  [GuildTargetID] nvarchar(255),
  [DateCreated] datetime
)
GO

CREATE TABLE [Posts] (
  [PostID] int PRIMARY KEY,
  [AuthorID] int,
  [PostTitle] nvarchar(255),
  [PostDesc] nvarchar(255),
  [LikeCount] int,
  [CommentCount] int,
  [ThreadID] int,
  [StatusID] int,
  [ImageID] nvarchar(255),
  [PostTypeID] int,
  [DateCreated] datetime,
  [PostLink] nvarchar(255),
  [Votes] int
)
GO

CREATE TABLE [Status] (
  [StatusID] int PRIMARY KEY,
  [StatusName] nvarchar(255),
  [Description] nvarchar(255)
)
GO

CREATE TABLE [PostFavorites] (
  [PostFavoritesID] int PRIMARY KEY,
  [PostID] int,
  [UserID] int,
  [DateCreated] datetime
)
GO

CREATE TABLE [PostCategories] (
  [PostCategoriesID] int PRIMARY KEY,
  [CategororyID] int,
  [PostID] int
)
GO

CREATE TABLE [Categories] (
  [ID] int UNIQUE PRIMARY KEY,
  [CategoryID] int UNIQUE,
  [CategoryName] nvarchar(255),
  [Description] nvarchar(255),
  [AuthorID] int,
  [DateCreated] datetime,
  [StatusID] int
)
GO

CREATE TABLE [Guilds] (
  [GuildID] int PRIMARY KEY,
  [AuthorID] int,
  [Description] nvarchar(255),
  [GroupCategororyType] int,
  [GroupName] nvarchar(255),
  [GuildGroupWebsite] nvarchar(255),
  [DateCreated] datetime,
  [GuildGroupLink] nvarchar(255)
)
GO

CREATE TABLE [Award] (
  [AwardID] int PRIMARY KEY,
  [AuthorID] int,
  [AwardDescription] nvarchar(255),
  [AwardCategororyType] nvarchar(255),
  [AwardName] nvarchar(255),
  [AwardLink] nvarchar(255),
  [AwardImage] nvarchar(255),
  [DateCreated] datetime,
  [AwardPrice] int
)
GO

CREATE TABLE [UserProjects] (
  [ProjectID] int PRIMARY KEY,
  [AuthorID] int,
  [ProjectDescription] nvarchar(255),
  [ProjectCategororyType] nvarchar(255),
  [ProjectName] nvarchar(255),
  [ProjectLink] nvarchar(255),
  [ProjectImage] nvarchar(255),
  [ProjectCost] int
)
GO

CREATE TABLE [Rooms] (
  [RoomID] int PRIMARY KEY,
  [AuthorID] int,
  [Description] nvarchar(255),
  [RoomImage] nvarchar(255),
  [RoomCategororyType] nvarchar(255),
  [RoomName] nvarchar(255),
  [RoomLink] nvarchar(255)
)
GO

CREATE TABLE [Collections] (
  [CollectionID] int PRIMARY KEY,
  [DateCreated] datetime,
  [AuthorID] int,
  [Description] nvarchar(255),
  [CollectionImage] nvarchar(255),
  [CollectionCategororyType] nvarchar(255),
  [CollectionName] nvarchar(255),
  [CollectionLink] nvarchar(255)
)
GO

CREATE TABLE [CollectionTags] (
  [CollectionTagID] int PRIMARY KEY,
  [CollectionID] int,
  [TagID] int
)
GO

CREATE TABLE [PostTags] (
  [PostTagID] int PRIMARY KEY,
  [PostID] int,
  [TagID] int
)
GO

CREATE TABLE [Tags] (
  [TagID] int PRIMARY KEY,
  [Tag] nvarchar(255)
)
GO

CREATE TABLE [UserStatus] (
  [user_statusID] int PRIMARY KEY,
  [user_status] nvarchar(255)
)
GO

CREATE TABLE [Reactions] (
  [ReactionID] int PRIMARY KEY,
  [ReactionName] nvarchar(255),
  [Description] nvarchar(255)
)
GO

CREATE TABLE [PostComments] (
  [PostCommentID] int PRIMARY KEY,
  [AuthorID] int,
  [Content] nvarchar(255),
  [DateCreated] datetime,
  [PostCommentLink] nvarchar(255),
  [Votes] int
)
GO

CREATE TABLE [Threads] (
  [ThreadID] int PRIMARY KEY,
  [Votes] int,
  [StatusID] int,
  [DateCreated] datetime,
  [ThreadLink] nvarchar(255),
  [AuthorID] int
)
GO

CREATE TABLE [Conversations] (
  [ConversationID] int PRIMARY KEY,
  [LastContent] nvarchar(255),
  [LastDatePosted] nvarchar(255),
  [ParticipantationID] nvarchar(255)
)
GO

CREATE TABLE [Devices] (
  [ID] int PRIMARY KEY,
  [DeviceID] nvarchar(255),
  [AuthorID] int,
  [DeviceType] nvarchar(255),
  [DeviceToken] nvarchar(255)
)
GO

CREATE TABLE [Access] (
  [ID] int PRIMARY KEY,
  [DeviceID] nvarchar(255),
  [AuthorID] int,
  [Token] nvarchar(255),
  [DateCreated] datetime
)
GO

CREATE TABLE [Participation] (
  [ParticipationID] int PRIMARY KEY,
  [AuthorID] int,
  [ConversationID] nvarchar(255),
  [ThreadID] nvarchar(255)
)
GO

CREATE TABLE [GuildMembers] (
  [ID] int PRIMARY KEY,
  [GuildID] int,
  [MemberID] nvarchar(255),
  [UserTypeID] int,
  [DateCreated] datetime
)
GO

CREATE TABLE [Subscrptions] (
  [SubID] int PRIMARY KEY,
  [SubName] nvarchar(255),
  [SubDesc] nvarchar(255)
)
GO

CREATE TABLE [UserType] (
  [UserTypeID] int PRIMARY KEY,
  [UserTypeName] nvarchar(255),
  [UserTypeDesc] nvarchar(255)
)
GO

CREATE TABLE [PostShare] (
  [PostShareID] int PRIMARY KEY,
  [PostShareDesc] nvarchar(255),
  [PostID] nvarchar(255),
  [DateCreated] datetime
)
GO

CREATE TABLE [Voting] (
  [VotingID] int PRIMARY KEY,
  [UpCount] nvarchar(255),
  [DownCount] nvarchar(255),
  [ThreadID] int,
  [PostID] nvarchar(255),
  [DateCreated] datetime
)
GO

CREATE TABLE [Message] (
  [MessageID] int PRIMARY KEY,
  [AuthorID] int,
  [TargetID] int,
  [Content] nvarchar(255),
  [DateCreated] datetime,
  [ConversationID] nvarchar(255)
)
GO

CREATE TABLE [Report] (
  [ReportID] int PRIMARY KEY,
  [AuthorID] int,
  [ReporterType] nvarchar(255),
  [ReportDesc] nvarchar(255),
  [ReportType] nvarchar(255),
  [DateCreated] datetime
)
GO

CREATE TABLE [DeletedConversations] (
  [DeletedConversationID] int PRIMARY KEY,
  [AuthorID] int,
  [ConversationID] nvarchar(255),
  [DateDeleted] datetime
)
GO

CREATE TABLE [DeletedMessages] (
  [DeletedMessageID] int PRIMARY KEY,
  [AuthorID] int,
  [MessageID] int,
  [DateDeleted] datetime
)
GO

CREATE TABLE [Image] (
  [ImageID] int PRIMARY KEY,
  [ImageName] nvarchar(255),
  [ImageDesc] nvarchar(255),
  [ImageType] nvarchar(255)
)
GO

CREATE TABLE [Locations] (
  [LocationID] int PRIMARY KEY,
  [City] nvarchar(255),
  [State] nvarchar(255),
  [ZipCode] nvarchar(255),
  [Country] nvarchar(255)
)
GO

CREATE TABLE [ExternalAccounts] (
  [ExternalAccountsID] int PRIMARY KEY,
  [AuthorID] int,
  [EmailAddress] nvarchar(255),
  [FacebookUsername] nvarchar(255),
  [TwitterUsername] nvarchar(255),
  [GitHubUsername] nvarchar(255),
  [InstagramUsername] nvarchar(255),
  [LinkedInUsername] nvarchar(255),
  [SnapChatUsername] nvarchar(255),
  [YouTubeUsername] nvarchar(255)
)
GO

CREATE TABLE [UserSettings] (
  [SettingsID] int PRIMARY KEY,
  [AuthorID] int,
  [NotificationNewsletter] nvarchar(255),
  [NotificationFollowers] nvarchar(255),
  [NotificationComments] nvarchar(255),
  [NotificationMessages] nvarchar(255)
)
GO

ALTER TABLE [users] ADD FOREIGN KEY ([UserID]) REFERENCES [UserProfile] ([UserProfileID])
GO

ALTER TABLE [users] ADD FOREIGN KEY ([UserProfileID]) REFERENCES [UserProfile] ([UserProfileID])
GO

ALTER TABLE [UserProfile] ADD FOREIGN KEY ([ProfileImage]) REFERENCES [Image] ([ImageID])
GO

ALTER TABLE [UserProfile] ADD FOREIGN KEY ([Following]) REFERENCES [UserFollowers] ([UserFollowID])
GO

ALTER TABLE [UserProfile] ADD FOREIGN KEY ([StatusID]) REFERENCES [Status] ([StatusID])
GO

ALTER TABLE [UserFollowers] ADD FOREIGN KEY ([SourceID]) REFERENCES [UserProfile] ([UserProfileID])
GO

ALTER TABLE [UserProfile] ADD FOREIGN KEY ([UserProfileID]) REFERENCES [UserFollowers] ([TargetID])
GO

ALTER TABLE [ContactConnections] ADD FOREIGN KEY ([ConnectorID]) REFERENCES [UserProfile] ([UserProfileID])
GO

ALTER TABLE [UserProfile] ADD FOREIGN KEY ([UserProfileID]) REFERENCES [ContactConnections] ([ConnectID])
GO

ALTER TABLE [BlockedList] ADD FOREIGN KEY ([BlockerID]) REFERENCES [UserProfile] ([UserProfileID])
GO

ALTER TABLE [UserProfile] ADD FOREIGN KEY ([UserProfileID]) REFERENCES [BlockedList] ([BlockeeID])
GO

ALTER TABLE [GuildFollowers] ADD FOREIGN KEY ([SourceID]) REFERENCES [UserProfile] ([UserProfileID])
GO

ALTER TABLE [Guilds] ADD FOREIGN KEY ([GuildID]) REFERENCES [GuildFollowers] ([GuildTargetID])
GO

ALTER TABLE [Posts] ADD FOREIGN KEY ([AuthorID]) REFERENCES [UserProfile] ([UserProfileID])
GO

ALTER TABLE [Posts] ADD FOREIGN KEY ([ThreadID]) REFERENCES [Threads] ([ThreadID])
GO

ALTER TABLE [Posts] ADD FOREIGN KEY ([StatusID]) REFERENCES [Status] ([StatusID])
GO

ALTER TABLE [Posts] ADD FOREIGN KEY ([ImageID]) REFERENCES [Image] ([ImageID])
GO

ALTER TABLE [Posts] ADD FOREIGN KEY ([Votes]) REFERENCES [Voting] ([VotingID])
GO

ALTER TABLE [PostFavorites] ADD FOREIGN KEY ([PostID]) REFERENCES [Posts] ([PostID])
GO

ALTER TABLE [PostFavorites] ADD FOREIGN KEY ([UserID]) REFERENCES [UserProfile] ([UserProfileID])
GO

ALTER TABLE [PostCategories] ADD FOREIGN KEY ([CategororyID]) REFERENCES [Categories] ([CategoryID])
GO

ALTER TABLE [PostCategories] ADD FOREIGN KEY ([PostID]) REFERENCES [Posts] ([PostID])
GO

ALTER TABLE [Categories] ADD FOREIGN KEY ([CategoryID]) REFERENCES [Categories] ([ID])
GO

ALTER TABLE [Categories] ADD FOREIGN KEY ([AuthorID]) REFERENCES [UserProfile] ([UserProfileID])
GO

ALTER TABLE [Categories] ADD FOREIGN KEY ([StatusID]) REFERENCES [Status] ([StatusID])
GO

ALTER TABLE [Guilds] ADD FOREIGN KEY ([AuthorID]) REFERENCES [UserProfile] ([UserProfileID])
GO

ALTER TABLE [Guilds] ADD FOREIGN KEY ([GroupCategororyType]) REFERENCES [Categories] ([CategoryID])
GO

ALTER TABLE [Award] ADD FOREIGN KEY ([AuthorID]) REFERENCES [UserProfile] ([UserProfileID])
GO

ALTER TABLE [Award] ADD FOREIGN KEY ([AwardCategororyType]) REFERENCES [Categories] ([CategoryID])
GO

ALTER TABLE [Award] ADD FOREIGN KEY ([AwardImage]) REFERENCES [Image] ([ImageID])
GO

ALTER TABLE [UserProjects] ADD FOREIGN KEY ([AuthorID]) REFERENCES [UserProfile] ([UserProfileID])
GO

ALTER TABLE [UserProjects] ADD FOREIGN KEY ([ProjectCategororyType]) REFERENCES [Categories] ([CategoryID])
GO

ALTER TABLE [UserProjects] ADD FOREIGN KEY ([ProjectImage]) REFERENCES [Image] ([ImageID])
GO

ALTER TABLE [Rooms] ADD FOREIGN KEY ([AuthorID]) REFERENCES [UserProfile] ([UserProfileID])
GO

ALTER TABLE [Rooms] ADD FOREIGN KEY ([RoomImage]) REFERENCES [Image] ([ImageID])
GO

ALTER TABLE [Rooms] ADD FOREIGN KEY ([RoomCategororyType]) REFERENCES [Categories] ([CategoryID])
GO

ALTER TABLE [Collections] ADD FOREIGN KEY ([AuthorID]) REFERENCES [UserProfile] ([UserProfileID])
GO

ALTER TABLE [Collections] ADD FOREIGN KEY ([CollectionImage]) REFERENCES [Image] ([ImageID])
GO

ALTER TABLE [Collections] ADD FOREIGN KEY ([CollectionCategororyType]) REFERENCES [Categories] ([CategoryID])
GO

ALTER TABLE [CollectionTags] ADD FOREIGN KEY ([CollectionID]) REFERENCES [Collections] ([CollectionID])
GO

ALTER TABLE [CollectionTags] ADD FOREIGN KEY ([TagID]) REFERENCES [Tags] ([TagID])
GO

ALTER TABLE [Posts] ADD FOREIGN KEY ([PostID]) REFERENCES [PostTags] ([PostID])
GO

ALTER TABLE [PostTags] ADD FOREIGN KEY ([TagID]) REFERENCES [Tags] ([TagID])
GO

ALTER TABLE [PostComments] ADD FOREIGN KEY ([AuthorID]) REFERENCES [UserProfile] ([UserProfileID])
GO

ALTER TABLE [PostComments] ADD FOREIGN KEY ([Votes]) REFERENCES [Voting] ([VotingID])
GO

ALTER TABLE [Threads] ADD FOREIGN KEY ([Votes]) REFERENCES [Voting] ([VotingID])
GO

ALTER TABLE [Threads] ADD FOREIGN KEY ([StatusID]) REFERENCES [Status] ([StatusID])
GO

ALTER TABLE [Threads] ADD FOREIGN KEY ([AuthorID]) REFERENCES [UserProfile] ([UserProfileID])
GO

ALTER TABLE [Conversations] ADD FOREIGN KEY ([ParticipantationID]) REFERENCES [Participation] ([ParticipationID])
GO

ALTER TABLE [Devices] ADD FOREIGN KEY ([AuthorID]) REFERENCES [UserProfile] ([UserProfileID])
GO

ALTER TABLE [Access] ADD FOREIGN KEY ([DeviceID]) REFERENCES [Devices] ([DeviceID])
GO

ALTER TABLE [Access] ADD FOREIGN KEY ([AuthorID]) REFERENCES [UserProfile] ([UserProfileID])
GO

ALTER TABLE [Participation] ADD FOREIGN KEY ([AuthorID]) REFERENCES [UserProfile] ([UserProfileID])
GO

ALTER TABLE [Participation] ADD FOREIGN KEY ([ConversationID]) REFERENCES [Conversations] ([ConversationID])
GO

ALTER TABLE [Participation] ADD FOREIGN KEY ([ThreadID]) REFERENCES [Threads] ([ThreadID])
GO

ALTER TABLE [GuildMembers] ADD FOREIGN KEY ([GuildID]) REFERENCES [Guilds] ([GuildID])
GO

ALTER TABLE [GuildMembers] ADD FOREIGN KEY ([MemberID]) REFERENCES [UserProfile] ([UserProfileID])
GO

ALTER TABLE [GuildMembers] ADD FOREIGN KEY ([UserTypeID]) REFERENCES [UserType] ([UserTypeID])
GO

ALTER TABLE [PostShare] ADD FOREIGN KEY ([PostID]) REFERENCES [Posts] ([PostID])
GO

ALTER TABLE [Voting] ADD FOREIGN KEY ([PostID]) REFERENCES [Posts] ([PostID])
GO

ALTER TABLE [Message] ADD FOREIGN KEY ([AuthorID]) REFERENCES [UserProfile] ([UserProfileID])
GO

ALTER TABLE [Message] ADD FOREIGN KEY ([TargetID]) REFERENCES [UserProfile] ([UserProfileID])
GO

ALTER TABLE [Message] ADD FOREIGN KEY ([ConversationID]) REFERENCES [Conversations] ([ConversationID])
GO

ALTER TABLE [Report] ADD FOREIGN KEY ([AuthorID]) REFERENCES [UserProfile] ([UserProfileID])
GO

ALTER TABLE [Report] ADD FOREIGN KEY ([ReporterType]) REFERENCES [UserType] ([UserTypeID])
GO

ALTER TABLE [DeletedConversations] ADD FOREIGN KEY ([AuthorID]) REFERENCES [UserProfile] ([UserProfileID])
GO

ALTER TABLE [DeletedConversations] ADD FOREIGN KEY ([ConversationID]) REFERENCES [Conversations] ([ConversationID])
GO

ALTER TABLE [DeletedMessages] ADD FOREIGN KEY ([AuthorID]) REFERENCES [UserProfile] ([UserProfileID])
GO

ALTER TABLE [DeletedMessages] ADD FOREIGN KEY ([MessageID]) REFERENCES [Message] ([MessageID])
GO

ALTER TABLE [ExternalAccounts] ADD FOREIGN KEY ([AuthorID]) REFERENCES [UserProfile] ([UserProfileID])
GO

ALTER TABLE [ExternalAccounts] ADD FOREIGN KEY ([EmailAddress]) REFERENCES [users] ([EmailAddress])
GO

ALTER TABLE [UserProfile] ADD FOREIGN KEY ([UserProfileID]) REFERENCES [UserSettings] ([AuthorID])
GO
