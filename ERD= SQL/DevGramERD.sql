CREATE TABLE `users` (
  `UserID` int PRIMARY KEY AUTO_INCREMENT,
  `UserProfileID` int,
  `EmailAddress` varchar(255),
  `Password` varchar(255),
  `PasswordHash` varchar(255)
);

CREATE TABLE `UserProfile` (
  `UserProfileID` int UNIQUE PRIMARY KEY,
  `FirstName` varchar(255),
  `LastName` varchar(255),
  `MiddleName` varchar(255),
  `IsActive` bool,
  `IsBlocked` bool,
  `Gender` varchar(255),
  `DateOfBirth` varchar(255),
  `Occupation` varchar(255),
  `Location` varchar(255),
  `About` varchar(255),
  `ProfileImage` varchar(255),
  `Following` varchar(255),
  `Followers` varchar(255),
  `PostLikes` varchar(255),
  `Activities` varchar(255),
  `Interests` varchar(255),
  `DateCreated` datetime,
  `UserType` varchar(255),
  `UserStatus` varchar(255),
  `StatusID` int,
  `UserProfileLink` varchar(255),
  `LastLogin` datetime
);

CREATE TABLE `UserFollowers` (
  `UserFollowID` int PRIMARY KEY,
  `SourceID` int,
  `TargetID` int,
  `DateCreated` datetime
);

CREATE TABLE `ContactConnections` (
  `ContactConnectionID` int PRIMARY KEY,
  `ConnectorID` int,
  `ConnectID` int,
  `DateCreated` datetime
);

CREATE TABLE `BlockedList` (
  `BlockID` int PRIMARY KEY,
  `BlockerID` int,
  `BlockeeID` int,
  `DateCreated` datetime
);

CREATE TABLE `GuildFollowers` (
  `GuildFollowID` int PRIMARY KEY,
  `SourceID` varchar(255),
  `GuildTargetID` varchar(255),
  `DateCreated` datetime
);

CREATE TABLE `Posts` (
  `PostID` int PRIMARY KEY,
  `AuthorID` int,
  `PostTitle` varchar(255),
  `PostDesc` varchar(255),
  `LikeCount` int,
  `CommentCount` int,
  `ThreadID` int,
  `StatusID` int,
  `ImageID` varchar(255),
  `PostTypeID` int,
  `DateCreated` datetime,
  `PostLink` varchar(255),
  `Votes` int
);

CREATE TABLE `Status` (
  `StatusID` int PRIMARY KEY,
  `StatusName` varchar(255),
  `Description` varchar(255)
);

CREATE TABLE `PostFavorites` (
  `PostFavoritesID` int PRIMARY KEY,
  `PostID` int,
  `UserID` int,
  `DateCreated` datetime
);

CREATE TABLE `PostCategories` (
  `PostCategoriesID` int PRIMARY KEY,
  `CategororyID` int,
  `PostID` int
);

CREATE TABLE `Categories` (
  `ID` int UNIQUE PRIMARY KEY,
  `CategoryID` int UNIQUE,
  `CategoryName` varchar(255),
  `Description` varchar(255),
  `AuthorID` int,
  `DateCreated` datetime,
  `StatusID` int
);

CREATE TABLE `Guilds` (
  `GuildID` int PRIMARY KEY,
  `AuthorID` int,
  `Description` varchar(255),
  `GroupCategororyType` int,
  `GroupName` varchar(255),
  `GuildGroupWebsite` varchar(255),
  `DateCreated` datetime,
  `GuildGroupLink` varchar(255)
);

CREATE TABLE `Award` (
  `AwardID` int PRIMARY KEY,
  `AuthorID` int,
  `AwardDescription` varchar(255),
  `AwardCategororyType` varchar(255),
  `AwardName` varchar(255),
  `AwardLink` varchar(255),
  `AwardImage` varchar(255),
  `DateCreated` datetime,
  `AwardPrice` int
);

CREATE TABLE `UserProjects` (
  `ProjectID` int PRIMARY KEY,
  `AuthorID` int,
  `ProjectDescription` varchar(255),
  `ProjectCategororyType` varchar(255),
  `ProjectName` varchar(255),
  `ProjectLink` varchar(255),
  `ProjectImage` varchar(255),
  `ProjectCost` int
);

CREATE TABLE `Rooms` (
  `RoomID` int PRIMARY KEY,
  `AuthorID` int,
  `Description` varchar(255),
  `RoomImage` varchar(255),
  `RoomCategororyType` varchar(255),
  `RoomName` varchar(255),
  `RoomLink` varchar(255)
);

CREATE TABLE `Collections` (
  `CollectionID` int PRIMARY KEY,
  `DateCreated` datetime,
  `AuthorID` int,
  `Description` varchar(255),
  `CollectionImage` varchar(255),
  `CollectionCategororyType` varchar(255),
  `CollectionName` varchar(255),
  `CollectionLink` varchar(255)
);

CREATE TABLE `CollectionTags` (
  `CollectionTagID` int PRIMARY KEY,
  `CollectionID` int,
  `TagID` int
);

CREATE TABLE `PostTags` (
  `PostTagID` int PRIMARY KEY,
  `PostID` int,
  `TagID` int
);

CREATE TABLE `Tags` (
  `TagID` int PRIMARY KEY,
  `Tag` varchar(255)
);

CREATE TABLE `UserStatus` (
  `user_statusID` int PRIMARY KEY,
  `user_status` varchar(255)
);

CREATE TABLE `Reactions` (
  `ReactionID` int PRIMARY KEY,
  `ReactionName` varchar(255),
  `Description` varchar(255)
);

CREATE TABLE `PostComments` (
  `PostCommentID` int PRIMARY KEY,
  `AuthorID` int,
  `Content` varchar(255),
  `DateCreated` datetime,
  `PostCommentLink` varchar(255),
  `Votes` int
);

CREATE TABLE `Threads` (
  `ThreadID` int PRIMARY KEY,
  `Votes` int,
  `StatusID` int,
  `DateCreated` datetime,
  `ThreadLink` varchar(255),
  `AuthorID` int
);

CREATE TABLE `Conversations` (
  `ConversationID` int PRIMARY KEY,
  `LastContent` varchar(255),
  `LastDatePosted` varchar(255),
  `ParticipantationID` varchar(255)
);

CREATE TABLE `Devices` (
  `ID` int PRIMARY KEY,
  `DeviceID` varchar(255),
  `AuthorID` int,
  `DeviceType` varchar(255),
  `DeviceToken` varchar(255)
);

CREATE TABLE `Access` (
  `ID` int PRIMARY KEY,
  `DeviceID` varchar(255),
  `AuthorID` int,
  `Token` varchar(255),
  `DateCreated` datetime
);

CREATE TABLE `Participation` (
  `ParticipationID` int PRIMARY KEY,
  `AuthorID` int,
  `ConversationID` varchar(255),
  `ThreadID` varchar(255)
);

CREATE TABLE `GuildMembers` (
  `ID` int PRIMARY KEY,
  `GuildID` int,
  `MemberID` varchar(255),
  `UserTypeID` int,
  `DateCreated` datetime
);

CREATE TABLE `Subscrptions` (
  `SubID` int PRIMARY KEY,
  `SubName` varchar(255),
  `SubDesc` varchar(255)
);

CREATE TABLE `UserType` (
  `UserTypeID` int PRIMARY KEY,
  `UserTypeName` varchar(255),
  `UserTypeDesc` varchar(255)
);

CREATE TABLE `PostShare` (
  `PostShareID` int PRIMARY KEY,
  `PostShareDesc` varchar(255),
  `PostID` varchar(255),
  `DateCreated` datetime
);

CREATE TABLE `Voting` (
  `VotingID` int PRIMARY KEY,
  `UpCount` varchar(255),
  `DownCount` varchar(255),
  `ThreadID` int,
  `PostID` varchar(255),
  `DateCreated` datetime
);

CREATE TABLE `Message` (
  `MessageID` int PRIMARY KEY,
  `AuthorID` int,
  `TargetID` int,
  `Content` varchar(255),
  `DateCreated` datetime,
  `ConversationID` varchar(255)
);

CREATE TABLE `Report` (
  `ReportID` int PRIMARY KEY,
  `AuthorID` int,
  `ReporterType` varchar(255),
  `ReportDesc` varchar(255),
  `ReportType` varchar(255),
  `DateCreated` datetime
);

CREATE TABLE `DeletedConversations` (
  `DeletedConversationID` int PRIMARY KEY,
  `AuthorID` int,
  `ConversationID` varchar(255),
  `DateDeleted` datetime
);

CREATE TABLE `DeletedMessages` (
  `DeletedMessageID` int PRIMARY KEY,
  `AuthorID` int,
  `MessageID` int,
  `DateDeleted` datetime
);

CREATE TABLE `Image` (
  `ImageID` int PRIMARY KEY,
  `ImageName` varchar(255),
  `ImageDesc` varchar(255),
  `ImageType` varchar(255)
);

CREATE TABLE `Locations` (
  `LocationID` int PRIMARY KEY,
  `City` varchar(255),
  `State` varchar(255),
  `ZipCode` varchar(255),
  `Country` varchar(255)
);

CREATE TABLE `ExternalAccounts` (
  `ExternalAccountsID` int PRIMARY KEY,
  `AuthorID` int,
  `EmailAddress` varchar(255),
  `FacebookUsername` varchar(255),
  `TwitterUsername` varchar(255),
  `GitHubUsername` varchar(255),
  `InstagramUsername` varchar(255),
  `LinkedInUsername` varchar(255),
  `SnapChatUsername` varchar(255),
  `YouTubeUsername` varchar(255)
);

CREATE TABLE `UserSettings` (
  `SettingsID` int PRIMARY KEY,
  `AuthorID` int,
  `NotificationNewsletter` varchar(255),
  `NotificationFollowers` varchar(255),
  `NotificationComments` varchar(255),
  `NotificationMessages` varchar(255)
);

ALTER TABLE `users` ADD FOREIGN KEY (`UserID`) REFERENCES `UserProfile` (`UserProfileID`);

ALTER TABLE `users` ADD FOREIGN KEY (`UserProfileID`) REFERENCES `UserProfile` (`UserProfileID`);

ALTER TABLE `UserProfile` ADD FOREIGN KEY (`ProfileImage`) REFERENCES `Image` (`ImageID`);

ALTER TABLE `UserProfile` ADD FOREIGN KEY (`Following`) REFERENCES `UserFollowers` (`UserFollowID`);

ALTER TABLE `UserProfile` ADD FOREIGN KEY (`StatusID`) REFERENCES `Status` (`StatusID`);

ALTER TABLE `UserFollowers` ADD FOREIGN KEY (`SourceID`) REFERENCES `UserProfile` (`UserProfileID`);

ALTER TABLE `UserProfile` ADD FOREIGN KEY (`UserProfileID`) REFERENCES `UserFollowers` (`TargetID`);

ALTER TABLE `ContactConnections` ADD FOREIGN KEY (`ConnectorID`) REFERENCES `UserProfile` (`UserProfileID`);

ALTER TABLE `UserProfile` ADD FOREIGN KEY (`UserProfileID`) REFERENCES `ContactConnections` (`ConnectID`);

ALTER TABLE `BlockedList` ADD FOREIGN KEY (`BlockerID`) REFERENCES `UserProfile` (`UserProfileID`);

ALTER TABLE `UserProfile` ADD FOREIGN KEY (`UserProfileID`) REFERENCES `BlockedList` (`BlockeeID`);

ALTER TABLE `GuildFollowers` ADD FOREIGN KEY (`SourceID`) REFERENCES `UserProfile` (`UserProfileID`);

ALTER TABLE `Guilds` ADD FOREIGN KEY (`GuildID`) REFERENCES `GuildFollowers` (`GuildTargetID`);

ALTER TABLE `Posts` ADD FOREIGN KEY (`AuthorID`) REFERENCES `UserProfile` (`UserProfileID`);

ALTER TABLE `Posts` ADD FOREIGN KEY (`ThreadID`) REFERENCES `Threads` (`ThreadID`);

ALTER TABLE `Posts` ADD FOREIGN KEY (`StatusID`) REFERENCES `Status` (`StatusID`);

ALTER TABLE `Posts` ADD FOREIGN KEY (`ImageID`) REFERENCES `Image` (`ImageID`);

ALTER TABLE `Posts` ADD FOREIGN KEY (`Votes`) REFERENCES `Voting` (`VotingID`);

ALTER TABLE `PostFavorites` ADD FOREIGN KEY (`PostID`) REFERENCES `Posts` (`PostID`);

ALTER TABLE `PostFavorites` ADD FOREIGN KEY (`UserID`) REFERENCES `UserProfile` (`UserProfileID`);

ALTER TABLE `PostCategories` ADD FOREIGN KEY (`CategororyID`) REFERENCES `Categories` (`CategoryID`);

ALTER TABLE `PostCategories` ADD FOREIGN KEY (`PostID`) REFERENCES `Posts` (`PostID`);

ALTER TABLE `Categories` ADD FOREIGN KEY (`CategoryID`) REFERENCES `Categories` (`ID`);

ALTER TABLE `Categories` ADD FOREIGN KEY (`AuthorID`) REFERENCES `UserProfile` (`UserProfileID`);

ALTER TABLE `Categories` ADD FOREIGN KEY (`StatusID`) REFERENCES `Status` (`StatusID`);

ALTER TABLE `Guilds` ADD FOREIGN KEY (`AuthorID`) REFERENCES `UserProfile` (`UserProfileID`);

ALTER TABLE `Guilds` ADD FOREIGN KEY (`GroupCategororyType`) REFERENCES `Categories` (`CategoryID`);

ALTER TABLE `Award` ADD FOREIGN KEY (`AuthorID`) REFERENCES `UserProfile` (`UserProfileID`);

ALTER TABLE `Award` ADD FOREIGN KEY (`AwardCategororyType`) REFERENCES `Categories` (`CategoryID`);

ALTER TABLE `Award` ADD FOREIGN KEY (`AwardImage`) REFERENCES `Image` (`ImageID`);

ALTER TABLE `UserProjects` ADD FOREIGN KEY (`AuthorID`) REFERENCES `UserProfile` (`UserProfileID`);

ALTER TABLE `UserProjects` ADD FOREIGN KEY (`ProjectCategororyType`) REFERENCES `Categories` (`CategoryID`);

ALTER TABLE `UserProjects` ADD FOREIGN KEY (`ProjectImage`) REFERENCES `Image` (`ImageID`);

ALTER TABLE `Rooms` ADD FOREIGN KEY (`AuthorID`) REFERENCES `UserProfile` (`UserProfileID`);

ALTER TABLE `Rooms` ADD FOREIGN KEY (`RoomImage`) REFERENCES `Image` (`ImageID`);

ALTER TABLE `Rooms` ADD FOREIGN KEY (`RoomCategororyType`) REFERENCES `Categories` (`CategoryID`);

ALTER TABLE `Collections` ADD FOREIGN KEY (`AuthorID`) REFERENCES `UserProfile` (`UserProfileID`);

ALTER TABLE `Collections` ADD FOREIGN KEY (`CollectionImage`) REFERENCES `Image` (`ImageID`);

ALTER TABLE `Collections` ADD FOREIGN KEY (`CollectionCategororyType`) REFERENCES `Categories` (`CategoryID`);

ALTER TABLE `CollectionTags` ADD FOREIGN KEY (`CollectionID`) REFERENCES `Collections` (`CollectionID`);

ALTER TABLE `CollectionTags` ADD FOREIGN KEY (`TagID`) REFERENCES `Tags` (`TagID`);

ALTER TABLE `Posts` ADD FOREIGN KEY (`PostID`) REFERENCES `PostTags` (`PostID`);

ALTER TABLE `PostTags` ADD FOREIGN KEY (`TagID`) REFERENCES `Tags` (`TagID`);

ALTER TABLE `PostComments` ADD FOREIGN KEY (`AuthorID`) REFERENCES `UserProfile` (`UserProfileID`);

ALTER TABLE `PostComments` ADD FOREIGN KEY (`Votes`) REFERENCES `Voting` (`VotingID`);

ALTER TABLE `Threads` ADD FOREIGN KEY (`Votes`) REFERENCES `Voting` (`VotingID`);

ALTER TABLE `Threads` ADD FOREIGN KEY (`StatusID`) REFERENCES `Status` (`StatusID`);

ALTER TABLE `Threads` ADD FOREIGN KEY (`AuthorID`) REFERENCES `UserProfile` (`UserProfileID`);

ALTER TABLE `Conversations` ADD FOREIGN KEY (`ParticipantationID`) REFERENCES `Participation` (`ParticipationID`);

ALTER TABLE `Devices` ADD FOREIGN KEY (`AuthorID`) REFERENCES `UserProfile` (`UserProfileID`);

ALTER TABLE `Access` ADD FOREIGN KEY (`DeviceID`) REFERENCES `Devices` (`DeviceID`);

ALTER TABLE `Access` ADD FOREIGN KEY (`AuthorID`) REFERENCES `UserProfile` (`UserProfileID`);

ALTER TABLE `Participation` ADD FOREIGN KEY (`AuthorID`) REFERENCES `UserProfile` (`UserProfileID`);

ALTER TABLE `Participation` ADD FOREIGN KEY (`ConversationID`) REFERENCES `Conversations` (`ConversationID`);

ALTER TABLE `Participation` ADD FOREIGN KEY (`ThreadID`) REFERENCES `Threads` (`ThreadID`);

ALTER TABLE `GuildMembers` ADD FOREIGN KEY (`GuildID`) REFERENCES `Guilds` (`GuildID`);

ALTER TABLE `GuildMembers` ADD FOREIGN KEY (`MemberID`) REFERENCES `UserProfile` (`UserProfileID`);

ALTER TABLE `GuildMembers` ADD FOREIGN KEY (`UserTypeID`) REFERENCES `UserType` (`UserTypeID`);

ALTER TABLE `PostShare` ADD FOREIGN KEY (`PostID`) REFERENCES `Posts` (`PostID`);

ALTER TABLE `Voting` ADD FOREIGN KEY (`PostID`) REFERENCES `Posts` (`PostID`);

ALTER TABLE `Message` ADD FOREIGN KEY (`AuthorID`) REFERENCES `UserProfile` (`UserProfileID`);

ALTER TABLE `Message` ADD FOREIGN KEY (`TargetID`) REFERENCES `UserProfile` (`UserProfileID`);

ALTER TABLE `Message` ADD FOREIGN KEY (`ConversationID`) REFERENCES `Conversations` (`ConversationID`);

ALTER TABLE `Report` ADD FOREIGN KEY (`AuthorID`) REFERENCES `UserProfile` (`UserProfileID`);

ALTER TABLE `Report` ADD FOREIGN KEY (`ReporterType`) REFERENCES `UserType` (`UserTypeID`);

ALTER TABLE `DeletedConversations` ADD FOREIGN KEY (`AuthorID`) REFERENCES `UserProfile` (`UserProfileID`);

ALTER TABLE `DeletedConversations` ADD FOREIGN KEY (`ConversationID`) REFERENCES `Conversations` (`ConversationID`);

ALTER TABLE `DeletedMessages` ADD FOREIGN KEY (`AuthorID`) REFERENCES `UserProfile` (`UserProfileID`);

ALTER TABLE `DeletedMessages` ADD FOREIGN KEY (`MessageID`) REFERENCES `Message` (`MessageID`);

ALTER TABLE `ExternalAccounts` ADD FOREIGN KEY (`AuthorID`) REFERENCES `UserProfile` (`UserProfileID`);

ALTER TABLE `ExternalAccounts` ADD FOREIGN KEY (`EmailAddress`) REFERENCES `users` (`EmailAddress`);

ALTER TABLE `UserProfile` ADD FOREIGN KEY (`UserProfileID`) REFERENCES `UserSettings` (`AuthorID`);
