CREATE DATABASE ProgrammingProjectsDB;

CREATE TABLE ProjectsUsers (
	UserId INT NOT NULL IDENTITY(1,1),
	FirstName NVARCHAR(45) NOT NULL,
	LastName NVARCHAR(45) NOT NULL,
	UserLogin NVARCHAR(45) NOT NULL,
	UserPassword NVARCHAR(45) NOT NULL,
	Age INT NOT NULL,
	RegistrationDate DATE NOT NULL,
	Sex CHAR(1) NOT NULL CHECK (Sex = 'k' OR Sex = 'm'),
	AvatarPath NVARCHAR(100),
	UserDescription NVARCHAR(100),
	CONSTRAINT pk_projectsusers PRIMARY KEY (UserId)
);

CREATE TABLE ProjectGroups (
	GroupId INT NOT NULL IDENTITY(1,1),
	Name NVARCHAR(45) NOT NULL,
	GroupDescription NVARCHAR(200),
	CreationDate DATE NOT NULL,
	CONSTRAINT pk_group PRIMARY KEY (GroupId)
);

CREATE TABLE UsersGroupsAllocations (
	UserId INT NOT NULL,
	GroupId INT NOT NULL,
	IsLeader BIT NOT NULL,
	AdoptionDate DATE NOT NULL,
	CONSTRAINT fk_usersgroupsallocations_projectsusers
		FOREIGN KEY (UserId)
		REFERENCES dbo.ProjectsUsers(UserId),
	CONSTRAINT fk_usersgroupsallocations_projectgroups
		FOREIGN KEY (GroupId)
		REFERENCES dbo.ProjectGroups(GroupId),
	CONSTRAINT pk_usersgroupsallocations PRIMARY KEY (UserId, GroupId)
);

CREATE TABLE Invitations (
	UserId INT NOT NULL,
	GroupId INT NOT NULL,
	Result CHAR(1) NOT NULL CHECK (Result = 'a' OR Result = 'r' OR Result = 'u'),
	CONSTRAINT fk_invitations_projectsusers
		FOREIGN KEY (UserId)
		REFERENCES dbo.ProjectsUsers(UserId),
	CONSTRAINT fk_invitations_projectgroups
		FOREIGN KEY (GroupId)
		REFERENCES dbo.ProjectGroups(GroupId),
	CONSTRAINT pk_invitations PRIMARY KEY (UserId, GroupId)
);

CREATE TABLE Projects (
	ProjectId INT NOT NULL IDENTITY(1,1),
	Name NVARCHAR(45) NOT NULL,
	ProjectDescription NVARCHAR(200) NOT NULL,
	ProjectSubject NVARCHAR(100) NOT NULL,
	LogoPath NVARCHAR(100),
	GroupId INT NOT NULL,
	CONSTRAINT fk_projects_projectgroups
		FOREIGN KEY (GroupId)
		REFERENCES dbo.ProjectGroups(GroupId),
	CONSTRAINT pk_projects PRIMARY KEY (ProjectId)
);

CREATE TABLE WatchedProjects (
	UserId INT NOT NULL,
	ProjectId INT NOT NULL,
	CONSTRAINT fk_watchedprojects_projectsusers
		FOREIGN KEY (UserId)
		REFERENCES dbo.ProjectsUsers(UserId),
	CONSTRAINT fk_watchedprojects_projects
		FOREIGN KEY (ProjectId)
		REFERENCES dbo.Projects(ProjectId),
	CONSTRAINT pk_watchedprojects PRIMARY KEY (UserId, ProjectId)
);

CREATE TABLE Examples (
	ExampleId INT NOT NULL IDENTITY(1,1),
	Title NVARCHAR(70) NOT NULL,
	ExampleDescription NVARCHAR(200),
	CreationDate DATE NOT NULL,
	Contents NVARCHAR(400) NOT NULL,
	ProjectId INT NOT NULL,
	UserId INT NOT NULL,
	CONSTRAINT fk_examples_projects
		FOREIGN KEY (ProjectId)
		REFERENCES dbo.Projects(ProjectId),
	CONSTRAINT fk_examples_projectsusers
		FOREIGN KEY (UserId)
		REFERENCES dbo.ProjectsUsers(UserId),
	CONSTRAINT pk_examples PRIMARY KEY (ExampleId)
);

CREATE TABLE Movies (
	MovieId INT NOT NULL IDENTITY(1,1),
	UploadDate DATE NOT NULL,
	Author NVARCHAR(45) NOT NULL,
	Name NVARCHAR(45) NOT NULL,
	PhotoPath NVARCHAR(100),
	MovieDescription NVARCHAR(200),
	MoviePath NVARCHAR(200) NOT NULL,
	ProjectId INT NOT NULL,
	CONSTRAINT fk_movies_projects
		FOREIGN KEY (ProjectId)
		REFERENCES dbo.Projects(ProjectId),
	CONSTRAINT pk_movies PRIMARY KEY (MovieId)
);

CREATE TABLE Resources (
	ResourceId INT NOT NULL IDENTITY(1,1),
	Name NVARCHAR(45) NOT NULL,
	UploadDate DATE NOT NULL,
	ResourceDescription NVARCHAR(200),
	ResourceType NVARCHAR(45) NOT NULL,
	ResourcePath NVARCHAR(200) NOT NULL,
	ProjectId INT NOT NULL,
	CONSTRAINT fk_resources_projects
		FOREIGN KEY (ProjectId)
		REFERENCES dbo.Projects(ProjectId),
	CONSTRAINT pk_resources PRIMARY KEY (ResourceId)
);

CREATE TABLE Tutorials (
	TutorialId INT NOT NULL IDENTITY(1,1),
	Name NVARCHAR(45) NOT NULL,
	TutorialDescription NVARCHAR(200) NOT NULL,
	CreationDate DATE NOT NULL,
	Contents NVARCHAR(1000) NOT NULL,
	ProjectId INT NOT NULL,
	UserId INT NOT NULL,
	CONSTRAINT fk_tutorials_projects
		FOREIGN KEY (ProjectId)
		REFERENCES dbo.Projects(ProjectId),
	CONSTRAINT fk_tutorials_projectsusers
		FOREIGN KEY (UserId)
		REFERENCES dbo.ProjectsUsers(UserId),
	CONSTRAINT pk_tutorials PRIMARY KEY (TutorialId)
);

CREATE TABLE TutorialImages (
	ImageId INT NOT NULL IDENTITY(1,1),
	ImageDescription NVARCHAR(150),
	ImagePath NVARCHAR(100) NOT NULL,
	TutorialId INT NOT NULL,
	CONSTRAINT fk_tutorialimages_tutorials
		FOREIGN KEY (TutorialId)
		REFERENCES dbo.Tutorials(TutorialId),
	CONSTRAINT pk_tutorialimages PRIMARY KEY (ImageId)
);

CREATE TABLE TutorialAnimations (
	AnimationId INT NOT NULL IDENTITY(1,1),
	AnimationDescription NVARCHAR(150),
	AnimationPath NVARCHAR(100) NOT NULL,
	TutorialId INT NOT NULL,
	CONSTRAINT fk_tutorialanimations_tutorials
		FOREIGN KEY (TutorialId)
		REFERENCES dbo.Tutorials(TutorialId),
	CONSTRAINT pk_tutorialanimations PRIMARY KEY (AnimationId)
);
