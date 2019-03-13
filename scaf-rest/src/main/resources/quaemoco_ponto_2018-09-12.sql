# ************************************************************
# Sequel Pro SQL dump
# Versão 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.18)
# Base de Dados: quaemoco_ponto
# Tempo de Geração: 2018-09-13 00:08:02 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump da tabela TB_CONFIGURACAO
# ------------------------------------------------------------

LOCK TABLES `TB_CONFIGURACAO` WRITE;
/*!40000 ALTER TABLE `TB_CONFIGURACAO` DISABLE KEYS */;

INSERT INTO `TB_CONFIGURACAO` (`COD_CONFIGURACAO`, `NOM_CONFIGURACAO`, `DES_CONFIGURACAO`)
VALUES
	(1,'url.autenticacao','http://localhost:8080/quaemo-autenticacao/api'),
	(2,'url.sistema','http://localhost:8080/quaemo-corporativo/api/corporativo/sistemas'),
	(3,'url.sistema.aplicacao.cliente','http://localhost:8080/quaemo-corporativo/api/corporativo/sistemas/{codSistema}/aplicacao-cliente'),
	(4,'url.sistema.perfil','http://localhost:8080/quaemo-corporativo/api/corporativo/sistemas/{codSistema}/perfis'),
	(5,'url.sistema.recurso','http://localhost:8080/quaemo-corporativo/api/corporativo/sistemas/{codSistema}/recursos'),
	(6,'url.sistema.usuario','http://localhost:8080/quaemo-corporativo/api/corporativo/sistemas/{codSistema}/usuarios'),
	(7,'url.sistema.usuario.menu','http://localhost:8080/quaemo-corporativo/api/corporativo/sistemas/{codSistema}/usuarios/menus'),
	(8,'url.sistema.usuario.status','http://localhost:8080/quaemo-corporativo/api/corporativo/sistemas/{codSistema}/usuarios/{codUsuario}/status'),
	(9,'url.usuario','http://localhost:8080/quaemo-corporativo/api/corporativo/usuarios/'),
	(10,'url.usuario.foto','http://localhost:8080/quaemo-corporativo/api/corporativo/usuarios/{codUsuario}/fotos'),
	(11,'url.usuario.login','http://localhost:8080/quaemo-corporativo/api/corporativo/usuarios/{login}'),
	(12,'url.usuario.senha','http://localhost:8080/quaemo-corporativo/api/corporativo/usuarios/{login}/senha');

/*!40000 ALTER TABLE `TB_CONFIGURACAO` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
