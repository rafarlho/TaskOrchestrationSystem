-- Criação da base de dados (se quiseres fazer isso manualmente, podes saltar esta parte)
IF DB_ID('TOSDatabase') IS NULL
    CREATE DATABASE TOSDatabase;
GO

USE TOSDatabase;
GO

-- Apagar schema se já existir (cuidado, apaga todas as tabelas dentro!)
IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'TOSDbSchema')
BEGIN
    EXEC sp_executesql N'DROP SCHEMA TOSDbSchema CASCADE'; -- funciona no Azure SQL MI, senão usa drop table individual
END
GO

-- Criar schema
CREATE SCHEMA TOSDbSchema;
GO

-- Apagar tabelas se existirem (por segurança)
DROP TABLE IF EXISTS TOSDbSchema.[task];
DROP TABLE IF EXISTS TOSDbSchema.[production_task];
DROP TABLE IF EXISTS TOSDbSchema.[production_station_member];
DROP TABLE IF EXISTS TOSDbSchema.[production_station];
DROP TABLE IF EXISTS TOSDbSchema.[organization_member];
DROP TABLE IF EXISTS TOSDbSchema.[organization];
DROP TABLE IF EXISTS TOSDbSchema.[user];
DROP TABLE IF EXISTS TOSDbSchema.[task_type];
DROP TABLE IF EXISTS TOSDbSchema.[priority];
DROP TABLE IF EXISTS TOSDbSchema.[status];
DROP TABLE IF EXISTS TOSDbSchema.[role];
GO

-- Tabelas base
CREATE TABLE TOSDbSchema.[user] (
  [id] INT PRIMARY KEY,
  [full_name] NVARCHAR(255),
  [username] NVARCHAR(255),
  [email] NVARCHAR(255),
  [created_at] DATETIME2,
  [latest_login] DATETIME2,
  [db_created_on] DATETIME2,
  [row_version] ROWVERSION,
  [db_status] BIT
);
GO

CREATE TABLE TOSDbSchema.[role] (
  [id] INT PRIMARY KEY,
  [role] NVARCHAR(255)
);
GO

CREATE TABLE TOSDbSchema.[organization] (
  [id] INT PRIMARY KEY,
  [name] NVARCHAR(255),
  [description] NVARCHAR(255),
  [location] NVARCHAR(255),
  [owner_id] INT,
  [db_created_on] DATETIME2,
  [row_version] ROWVERSION,
  [db_status] BIT,
  FOREIGN KEY ([owner_id]) REFERENCES TOSDbSchema.[user]([id])
);
GO

CREATE TABLE TOSDbSchema.[organization_member] (
  [id] INT PRIMARY KEY,
  [organization_id] INT,
  [user_id] INT,
  [role_id] INT,
  FOREIGN KEY ([organization_id]) REFERENCES TOSDbSchema.[organization]([id]),
  FOREIGN KEY ([user_id]) REFERENCES TOSDbSchema.[user]([id]),
  FOREIGN KEY ([role_id]) REFERENCES TOSDbSchema.[role]([id])
);
GO

CREATE TABLE TOSDbSchema.[production_station] (
  [id] INT PRIMARY KEY,
  [organization_id] INT,
  [name] NVARCHAR(255),
  [description] NVARCHAR(255),
  FOREIGN KEY ([organization_id]) REFERENCES TOSDbSchema.[organization]([id])
);
GO

CREATE TABLE TOSDbSchema.[production_station_member] (
  [id] INT PRIMARY KEY,
  [production_station_id] INT,
  [organization_member_id] INT,
  FOREIGN KEY ([production_station_id]) REFERENCES TOSDbSchema.[production_station]([id]),
  FOREIGN KEY ([organization_member_id]) REFERENCES TOSDbSchema.[organization_member]([id])
);
GO

CREATE TABLE TOSDbSchema.[priority] (
  [id] INT PRIMARY KEY,
  [priority] NVARCHAR(255)
);
GO

CREATE TABLE TOSDbSchema.[status] (
  [id] INT PRIMARY KEY,
  [status] NVARCHAR(255)
);
GO

CREATE TABLE TOSDbSchema.[task_type] (
  [id] INT PRIMARY KEY,
  [type] NVARCHAR(255)
);
GO

CREATE TABLE TOSDbSchema.[production_task] (
  [id] INT PRIMARY KEY,
  [title] NVARCHAR(255),
  [description] NVARCHAR(255),
  [create_by_id] INT,
  [organization_id] INT,
  [started_at] DATETIME2,
  [finished_at] DATETIME2,
  [status_id] INT,
  [priority_id] INT,
  [db_created_on] DATETIME2,
  [row_version] ROWVERSION,
  [db_status] BIT,
  FOREIGN KEY ([create_by_id]) REFERENCES TOSDbSchema.[organization_member]([id]),
  FOREIGN KEY ([organization_id]) REFERENCES TOSDbSchema.[organization]([id]),
  FOREIGN KEY ([status_id]) REFERENCES TOSDbSchema.[status]([id]),
  FOREIGN KEY ([priority_id]) REFERENCES TOSDbSchema.[priority]([id])
);
GO

CREATE TABLE TOSDbSchema.[task] (
  [id] INT PRIMARY KEY,
  [production_task_id] INT,
  [title] NVARCHAR(255),
  [description] NVARCHAR(255),
  [task_type_id] INT,
  [production_station_id] INT,
  [production_station_member_id] INT,
  [scheduled_to] DATETIME2,
  [started_on] DATETIME2,
  [finished_on] DATETIME2,
  [estimated_duration] INT,
  [status_id] INT,
  [db_created_on] DATETIME2,
  [row_version] ROWVERSION,
  [db_status] BIT,
  FOREIGN KEY ([production_task_id]) REFERENCES TOSDbSchema.[production_task]([id]),
  FOREIGN KEY ([task_type_id]) REFERENCES TOSDbSchema.[task_type]([id]),
  FOREIGN KEY ([production_station_id]) REFERENCES TOSDbSchema.[production_station]([id]),
  FOREIGN KEY ([production_station_member_id]) REFERENCES TOSDbSchema.[production_station_member]([id]),
  FOREIGN KEY ([status_id]) REFERENCES TOSDbSchema.[status]([id])
);
GO
