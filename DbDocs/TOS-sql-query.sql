-- Criação da base de dados
IF DB_ID('TOSDatabase') IS NULL
    CREATE DATABASE TOSDatabase;
GO

USE TOSDatabase;
GO

-- Apagar schema se já existir
IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'TOSDbSchema')
BEGIN
    EXEC('DROP SCHEMA TOSDbSchema CASCADE'); -- Nota: "CASCADE" só funciona em Azure SQL Managed Instance
END
GO

-- Criar schema
CREATE SCHEMA TOSDbSchema;
GO

-- Apagar tabelas se existirem
DROP TABLE IF EXISTS TOSDbSchema.[Task];
DROP TABLE IF EXISTS TOSDbSchema.[ProductionTask];
DROP TABLE IF EXISTS TOSDbSchema.[ProductionStationMember];
DROP TABLE IF EXISTS TOSDbSchema.[ProductionStation];
DROP TABLE IF EXISTS TOSDbSchema.[OrganizationMember];
DROP TABLE IF EXISTS TOSDbSchema.[Organization];
DROP TABLE IF EXISTS TOSDbSchema.[User];
DROP TABLE IF EXISTS TOSDbSchema.[TaskType];
DROP TABLE IF EXISTS TOSDbSchema.[Priority];
DROP TABLE IF EXISTS TOSDbSchema.[Status];
DROP TABLE IF EXISTS TOSDbSchema.[Role];
GO

-- Tabelas

CREATE TABLE TOSDbSchema.[User] (
  [Id] INT IDENTITY(1,1) PRIMARY KEY,
  [FullName] NVARCHAR(255),
  [Username] NVARCHAR(255) NOT NULL,
  [Email] NVARCHAR(255) NOT NULL,
  [LatestLogin] DATETIME2 ,
  [DbCreatedOn] DATETIME2 NOT NULL,
  [RowVersion] ROWVERSION NOT NULL,
  [DbStatus] BIT NOT NULL
);
GO

CREATE TABLE TOSDbSchema.[Role] (
  [Id] INT IDENTITY(1,1) PRIMARY KEY,
  [Role] NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE TOSDbSchema.[Organization] (
  [Id] INT IDENTITY(1,1) PRIMARY KEY,
  [Name] NVARCHAR(255) NOT NULL,
  [Description] NVARCHAR(255) NOT NULL,
  [Location] NVARCHAR(255) NOT NULL,
  [OwnerId] INT NOT NULL,
  [DbCreatedOn] DATETIME2 NOT NULL,
  [RowVersion] ROWVERSION NOT NULL,
  [DbStatus] BIT NOT NULL,
  FOREIGN KEY ([OwnerId]) REFERENCES TOSDbSchema.[User]([Id])
);
GO

CREATE TABLE TOSDbSchema.[OrganizationMember] (
  [Id] INT IDENTITY(1,1) PRIMARY KEY,
  [OrganizationId] INT NOT NULL,
  [UserId] INT NOT NULL,
  [RoleId] INT NOT NULL,
  FOREIGN KEY ([OrganizationId]) REFERENCES TOSDbSchema.[Organization]([Id]),
  FOREIGN KEY ([UserId]) REFERENCES TOSDbSchema.[User]([Id]),
  FOREIGN KEY ([RoleId]) REFERENCES TOSDbSchema.[Role]([Id])
);
GO

CREATE TABLE TOSDbSchema.[ProductionStation] (
  [Id] INT IDENTITY(1,1) PRIMARY KEY,
  [OrganizationId] INT NOT NULL,
  [Name] NVARCHAR(255) NOT NULL,
  [Description] NVARCHAR(255),
  FOREIGN KEY ([OrganizationId]) REFERENCES TOSDbSchema.[Organization]([Id])
);
GO

CREATE TABLE TOSDbSchema.[ProductionStationMember] (
  [Id] INT IDENTITY(1,1) PRIMARY KEY,
  [ProductionStationId] INT NOT NULL,
  [OrganizationMemberId] INT NOT NULL,
  FOREIGN KEY ([ProductionStationId]) REFERENCES TOSDbSchema.[ProductionStation]([Id]),
  FOREIGN KEY ([OrganizationMemberId]) REFERENCES TOSDbSchema.[OrganizationMember]([Id])
);
GO

CREATE TABLE TOSDbSchema.[Priority] (
  [Id] INT IDENTITY(1,1) PRIMARY KEY,
  [Priority] NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE TOSDbSchema.[Status] (
  [Id] INT IDENTITY(1,1) PRIMARY KEY,
  [Status] NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE TOSDbSchema.[TaskType] (
  [Id] INT IDENTITY(1,1) PRIMARY KEY,
  [Type] NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE TOSDbSchema.[ProductionTask] (
  [Id] INT IDENTITY(1,1) PRIMARY KEY,
  [Title] NVARCHAR(255) NOT NULL,
  [Description] NVARCHAR(255),
  [CreatedById] INT NOT NULL,
  [OrganizationId] INT NOT NULL,
  [StartedOn] DATETIME2 NOT NULL,
  [FinishedOn] DATETIME2 NOT NULL,
  [StatusId] INT NOT NULL,
  [PriorityId] INT NOT NULL,
  [DbCreatedOn] DATETIME2 NOT NULL,
  [RowVersion] ROWVERSION NOT NULL,
  [DbStatus] BIT NOT NULL,
  FOREIGN KEY ([CreatedById]) REFERENCES TOSDbSchema.[OrganizationMember]([Id]),
  FOREIGN KEY ([OrganizationId]) REFERENCES TOSDbSchema.[Organization]([Id]),
  FOREIGN KEY ([StatusId]) REFERENCES TOSDbSchema.[Status]([Id]),
  FOREIGN KEY ([PriorityId]) REFERENCES TOSDbSchema.[Priority]([Id])
);
GO

CREATE TABLE TOSDbSchema.[Task] (
  [Id] INT IDENTITY(1,1) PRIMARY KEY,
  [ProductionTaskId] INT NOT NULL,
  [Title] NVARCHAR(255) NOT NULL,
  [Description] NVARCHAR(255),
  [TaskTypeId] INT NOT NULL,
  [ProductionStationId] INT NOT NULL,
  [ProductionStationMemberId] INT NOT NULL,
  [ScheduledTo] DATETIME2 NOT NULL,
  [StartedOn] DATETIME2,
  [FinishedOn] DATETIME2,
  [EstimatedDuration] INT,
  [StatusId] INT NOT NULL,
  [DbCreatedOn] DATETIME2 NOT NULL,
  [RowVersion] ROWVERSION NOT NULL,
  [DbStatus] BIT NOT NULL,
  FOREIGN KEY ([ProductionTaskId]) REFERENCES TOSDbSchema.[ProductionTask]([Id]),
  FOREIGN KEY ([TaskTypeId]) REFERENCES TOSDbSchema.[TaskType]([Id]),
  FOREIGN KEY ([ProductionStationId]) REFERENCES TOSDbSchema.[ProductionStation]([Id]),
  FOREIGN KEY ([ProductionStationMemberId]) REFERENCES TOSDbSchema.[ProductionStationMember]([Id]),
  FOREIGN KEY ([StatusId]) REFERENCES TOSDbSchema.[Status]([Id])
);
GO
