CREATE DATABASE [TestIntegrationDB4]
GO

ALTER DATABASE [TestIntegrationDB4] SET COMPATIBILITY_LEVEL = 130
GO
ALTER DATABASE [TestIntegrationDB4] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TestIntegrationDB4] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TestIntegrationDB4] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TestIntegrationDB4] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TestIntegrationDB4] SET ARITHABORT OFF 
GO
ALTER DATABASE [TestIntegrationDB4] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TestIntegrationDB4] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TestIntegrationDB4] SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF)
GO
ALTER DATABASE [TestIntegrationDB4] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TestIntegrationDB4] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TestIntegrationDB4] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TestIntegrationDB4] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TestIntegrationDB4] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TestIntegrationDB4] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TestIntegrationDB4] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TestIntegrationDB4] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TestIntegrationDB4] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TestIntegrationDB4] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TestIntegrationDB4] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TestIntegrationDB4] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TestIntegrationDB4] SET  READ_WRITE 
GO
ALTER DATABASE [TestIntegrationDB4] SET RECOVERY FULL 
GO
ALTER DATABASE [TestIntegrationDB4] SET  MULTI_USER 
GO
ALTER DATABASE [TestIntegrationDB4] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TestIntegrationDB4] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TestIntegrationDB4] SET DELAYED_DURABILITY = DISABLED 
GO
USE [TestIntegrationDB4]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = Off;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = Primary;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = On;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = Primary;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = Off;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = Primary;
GO
USE [TestIntegrationDB4]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [TestIntegrationDB4] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO
