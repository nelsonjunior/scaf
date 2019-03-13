# ************************************************************
# Sequel Pro SQL dump
# Versão 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.18)
# Base de Dados: quaemoco_scaf
# Tempo de Geração: 2019-03-13 12:13:46 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump da tabela RL_LANCAMENTO_PARCELA
# ------------------------------------------------------------

DROP TABLE IF EXISTS `RL_LANCAMENTO_PARCELA`;

CREATE TABLE `RL_LANCAMENTO_PARCELA` (
  `COD_PARCELA` int(11) NOT NULL,
  `COD_LANCAMENTO` int(11) NOT NULL,
  PRIMARY KEY (`COD_PARCELA`,`COD_LANCAMENTO`),
  KEY `COD_LANCAMENTO` (`COD_LANCAMENTO`),
  KEY `COD_PARCELA` (`COD_PARCELA`),
  CONSTRAINT `FK_LANCAMENTO_PARCELA_LANCAMENTO` FOREIGN KEY (`COD_LANCAMENTO`) REFERENCES `TB_LANCAMENTO` (`COD_LANCAMENTO`),
  CONSTRAINT `FK_LANCAMENTO_PARCELA_PARCELA` FOREIGN KEY (`COD_PARCELA`) REFERENCES `TB_PARCELA` (`COD_PARCELA`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `RL_LANCAMENTO_PARCELA` WRITE;
/*!40000 ALTER TABLE `RL_LANCAMENTO_PARCELA` DISABLE KEYS */;

INSERT INTO `RL_LANCAMENTO_PARCELA` (`COD_PARCELA`, `COD_LANCAMENTO`)
VALUES
	(68,26);

/*!40000 ALTER TABLE `RL_LANCAMENTO_PARCELA` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela TB_AGENDAMENTO
# ------------------------------------------------------------

DROP TABLE IF EXISTS `TB_AGENDAMENTO`;

CREATE TABLE `TB_AGENDAMENTO` (
  `COD_AGENDAMENTO` int(11) NOT NULL AUTO_INCREMENT,
  `NUM_PERIODO` int(11) NOT NULL,
  `COD_CATEGORIA` int(11) NOT NULL,
  `COD_USUARIO` int(11) NOT NULL,
  `NOM_AGENDAMENTO` varchar(250) NOT NULL,
  `DES_AGENDAMENTO` varchar(4000) DEFAULT NULL,
  `DES_TAGS` varchar(4000) DEFAULT NULL,
  `DAT_INCLUSAO` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `DAT_ALTERACAO` timestamp NULL DEFAULT NULL,
  `DAT_INICIO` date NOT NULL,
  `IND_ATIVO` int(11) NOT NULL DEFAULT '1',
  `IND_EXCLUIDO` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`COD_AGENDAMENTO`),
  KEY `COD_CATEGORIA` (`COD_CATEGORIA`),
  KEY `NUM_PERIODO` (`NUM_PERIODO`),
  CONSTRAINT `FK_AGENDAMENTO_CATEGORIA` FOREIGN KEY (`COD_CATEGORIA`) REFERENCES `TB_CATEGORIA` (`COD_CATEGORIA`),
  CONSTRAINT `FK_AGENDAMENTO_PERIODO` FOREIGN KEY (`NUM_PERIODO`) REFERENCES `TB_PERIODO` (`NUM_PERIODO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `TB_AGENDAMENTO` WRITE;
/*!40000 ALTER TABLE `TB_AGENDAMENTO` DISABLE KEYS */;

INSERT INTO `TB_AGENDAMENTO` (`COD_AGENDAMENTO`, `NUM_PERIODO`, `COD_CATEGORIA`, `COD_USUARIO`, `NOM_AGENDAMENTO`, `DES_AGENDAMENTO`, `DES_TAGS`, `DAT_INCLUSAO`, `DAT_ALTERACAO`, `DAT_INICIO`, `IND_ATIVO`, `IND_EXCLUIDO`)
VALUES
	(1,1,1,1,'teste','kct du carai','','2018-09-12 23:49:55','2018-09-12 23:53:48','2018-10-07',1,0),
	(2,2,6,1,'VIVO Ação','alguma coisa','','2018-09-18 10:54:00',NULL,'2017-12-31',1,0);

/*!40000 ALTER TABLE `TB_AGENDAMENTO` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela TB_CARTAO_CREDITO
# ------------------------------------------------------------

DROP TABLE IF EXISTS `TB_CARTAO_CREDITO`;

CREATE TABLE `TB_CARTAO_CREDITO` (
  `COD_CARTAO_CREDITO` int(11) NOT NULL AUTO_INCREMENT,
  `COD_USUARIO` int(11) NOT NULL,
  `NOM_BANDEIRA` varchar(50) NOT NULL,
  `NOM_CARTAO_CREDITO` varchar(100) NOT NULL,
  `NUM_DIA_VENCIMENTO` int(11) NOT NULL,
  `NUM_DIA_FECHAMENTO` int(11) NOT NULL,
  `DAT_INCLUSAO` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `DAT_ALTERACAO` timestamp NULL DEFAULT NULL,
  `IND_ATIVO` int(11) NOT NULL DEFAULT '1',
  `IND_EXCLUIDO` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`COD_CARTAO_CREDITO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `TB_CARTAO_CREDITO` WRITE;
/*!40000 ALTER TABLE `TB_CARTAO_CREDITO` DISABLE KEYS */;

INSERT INTO `TB_CARTAO_CREDITO` (`COD_CARTAO_CREDITO`, `COD_USUARIO`, `NOM_BANDEIRA`, `NOM_CARTAO_CREDITO`, `NUM_DIA_VENCIMENTO`, `NUM_DIA_FECHAMENTO`, `DAT_INCLUSAO`, `DAT_ALTERACAO`, `IND_ATIVO`, `IND_EXCLUIDO`)
VALUES
	(1,1,'MASTER','sicoob',10,25,'2018-09-12 23:43:20',NULL,1,0);

/*!40000 ALTER TABLE `TB_CARTAO_CREDITO` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela TB_CATEGORIA
# ------------------------------------------------------------

DROP TABLE IF EXISTS `TB_CATEGORIA`;

CREATE TABLE `TB_CATEGORIA` (
  `COD_CATEGORIA` int(11) NOT NULL,
  `COD_GRUPO` int(11) NOT NULL,
  `NOM_CATEGORIA` varchar(500) NOT NULL,
  `IND_ATIVO` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`COD_CATEGORIA`),
  KEY `COD_GRUPO` (`COD_GRUPO`),
  CONSTRAINT `FK_CATEGORIA_GRUPO` FOREIGN KEY (`COD_GRUPO`) REFERENCES `TB_GRUPO` (`COD_GRUPO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `TB_CATEGORIA` WRITE;
/*!40000 ALTER TABLE `TB_CATEGORIA` DISABLE KEYS */;

INSERT INTO `TB_CATEGORIA` (`COD_CATEGORIA`, `COD_GRUPO`, `NOM_CATEGORIA`, `IND_ATIVO`)
VALUES
	(1,1,'Aluguel',1),
	(2,1,'Condomínio',1),
	(3,1,'Água',1),
	(4,1,'Energia Elétrica',1),
	(5,1,'Gás',1),
	(6,1,'Telefone',1),
	(7,1,'Internet',1),
	(8,1,'TV a Cabo',1),
	(9,1,'Manutenção',1),
	(10,1,'Impostos e Taxas',1),
	(11,1,'Seguro',1),
	(12,2,'Mercado',1),
	(13,2,'Açougue',1),
	(14,2,'Padaria',1),
	(15,2,'Feira',1),
	(16,2,'Restaurantes',1),
	(17,2,'Outros',1),
	(18,3,'Combustível',1),
	(19,3,'Transporte Escolar',1),
	(20,3,'Manutenção',1),
	(21,3,'Impostos e Taxas',1),
	(22,3,'Seguro',1),
	(23,3,'Lavagens',1),
	(24,3,'MULTAS',1),
	(25,3,'Outros',1),
	(26,3,'Estacionamentos',1),
	(27,4,'Plano de Saúde',1),
	(28,4,'Farmácia',1),
	(29,4,'Consultas sem Plano de Saúde',1),
	(30,4,'Outros',1),
	(31,5,'Escola',1),
	(32,5,'Faculdade',1),
	(33,5,'Curso',1),
	(34,5,'Material Escolar',1),
	(35,5,'Livros',1),
	(36,6,'Academia',1),
	(37,6,'Jornais e Revistas',1),
	(38,6,'Cinema e Passeios',1),
	(39,6,'Viagens',1),
	(40,6,'Shows e Eventos',1),
	(41,7,'Pagamento de Serviços',1),
	(42,7,'Aplicação em fundos',1),
	(43,7,'PGBL',1),
	(44,7,'Aplicação em Poupança',1),
	(45,7,'Cartões de Crédito',0),
	(46,7,'Pagamento de Parcela',1),
	(47,7,'Financiamento',0),
	(48,7,'Pagamento de Fatura',1),
	(49,7,'Pagamento de Serviços',0),
	(50,7,'Quitação',1),
	(51,7,'Empréstimo',0),
	(52,8,'Vestuário',1),
	(53,8,'Outros',1),
	(54,8,'Informática e Games',1),
	(55,8,'Eletro Eletrônico',1),
	(56,8,'Ferramentas',1),
	(57,9,'Salário',1),
	(58,9,'Bolsas',1),
	(59,9,'13º Salário',1),
	(60,9,'Férias',1),
	(61,9,'Retirada de Poupança',1),
	(62,9,'Retirada de Aplicações',1),
	(63,9,'Empréstimos',1),
	(64,9,'Outros',1),
	(65,10,'Escola/Faculdade',1),
	(66,10,'Cursos',1),
	(67,10,'Material Escolar',1),
	(68,10,'Esportes/Uniformes',1),
	(69,10,'Mesada',1),
	(70,10,'Passeios/Férias',1),
	(71,10,'Vestuário',1),
	(72,10,'Saúde/Medicamentos',1),
	(73,10,'Outros',1),
	(74,10,'Pensão Alimentícia',1);

/*!40000 ALTER TABLE `TB_CATEGORIA` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela TB_CONFIGURACAO
# ------------------------------------------------------------

DROP TABLE IF EXISTS `TB_CONFIGURACAO`;

CREATE TABLE `TB_CONFIGURACAO` (
  `COD_CONFIGURACAO` int(11) NOT NULL AUTO_INCREMENT,
  `NOM_CONFIGURACAO` varchar(100) NOT NULL,
  `DES_CONFIGURACAO` varchar(400) DEFAULT NULL,
  PRIMARY KEY (`COD_CONFIGURACAO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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


# Dump da tabela TB_CONTATO
# ------------------------------------------------------------

DROP TABLE IF EXISTS `TB_CONTATO`;

CREATE TABLE `TB_CONTATO` (
  `COD_CONTATO` int(11) NOT NULL AUTO_INCREMENT,
  `NOM_CONTATO` varchar(250) NOT NULL,
  `NOM_ASSUNTO` varchar(250) NOT NULL,
  `DES_EMAIL` varchar(100) NOT NULL,
  `DES_MENSAGEM` text NOT NULL,
  `DAT_INCLUSAO` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `IND_EXCLUIDO` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`COD_CONTATO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `TB_CONTATO` WRITE;
/*!40000 ALTER TABLE `TB_CONTATO` DISABLE KEYS */;

INSERT INTO `TB_CONTATO` (`COD_CONTATO`, `NOM_CONTATO`, `NOM_ASSUNTO`, `DES_EMAIL`, `DES_MENSAGEM`, `DAT_INCLUSAO`, `IND_EXCLUIDO`)
VALUES
	(1,'Willian Maruno','teste de Contato','jackmaruno@gmail.com','teste de Contato teste de Contato teste de Contato teste de Contato teste de Contato','2019-03-02 11:14:40',0),
	(2,'Willian Maruno','2 teste de Contato','jackmaruno@gmail.com','2 teste de Contato teste de Contato teste de Contato teste de Contato teste de Contato','2019-03-02 11:15:16',0),
	(3,'Willian Maruno','3 teste de Contato','jackmaruno@gmail.com','3 teste de Contato teste de Contato teste de Contato teste de Contato teste de Contato','2019-03-02 11:15:20',0);

/*!40000 ALTER TABLE `TB_CONTATO` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela TB_GRUPO
# ------------------------------------------------------------

DROP TABLE IF EXISTS `TB_GRUPO`;

CREATE TABLE `TB_GRUPO` (
  `COD_GRUPO` int(11) NOT NULL,
  `NOM_GRUPO` varchar(100) NOT NULL,
  `IND_ATIVO` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`COD_GRUPO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `TB_GRUPO` WRITE;
/*!40000 ALTER TABLE `TB_GRUPO` DISABLE KEYS */;

INSERT INTO `TB_GRUPO` (`COD_GRUPO`, `NOM_GRUPO`, `IND_ATIVO`)
VALUES
	(1,'Moradia',1),
	(2,'Despesas',1),
	(3,'Transporte',1),
	(4,'Saúde e Cuidados',1),
	(5,'Educação',1),
	(6,'Lazer',1),
	(7,'Operações Financeiras',1),
	(8,'Compras Diversas',1),
	(9,'Receitas',1),
	(10,'Dependentes',1);

/*!40000 ALTER TABLE `TB_GRUPO` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela TB_LANCAMENTO
# ------------------------------------------------------------

DROP TABLE IF EXISTS `TB_LANCAMENTO`;

CREATE TABLE `TB_LANCAMENTO` (
  `COD_LANCAMENTO` int(11) NOT NULL AUTO_INCREMENT,
  `COD_PARCELA` int(11) DEFAULT NULL,
  `COD_AGENDAMENTO` int(11) DEFAULT NULL,
  `COD_CARTAO_CREDITO` int(11) DEFAULT NULL,
  `COD_CATEGORIA` int(11) NOT NULL,
  `COD_USUARIO` int(11) NOT NULL,
  `COD_TIPO_PAGAMENTO` int(11) DEFAULT '1',
  `DES_TAGS` varchar(4000) DEFAULT NULL,
  `VAL_PREVISTO` decimal(26,2) NOT NULL DEFAULT '0.00',
  `VAL_LANCAMENTO` decimal(26,2) NOT NULL DEFAULT '0.00',
  `DES_LANCAMENTO` text,
  `DAT_REFERENCIA` date NOT NULL,
  `DAT_LANCAMENTO` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `DAT_FATURA` date DEFAULT NULL,
  `DAT_ALTERACAO` timestamp NULL DEFAULT NULL,
  `IND_EXCLUIDO` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`COD_LANCAMENTO`),
  KEY `COD_CATEGORIA` (`COD_CATEGORIA`),
  KEY `COD_CARTAO_CREDITO` (`COD_CARTAO_CREDITO`),
  KEY `COD_AGENDAMENTO` (`COD_AGENDAMENTO`),
  KEY `COD_PARCELA` (`COD_PARCELA`),
  CONSTRAINT `FK_LANCAMENTO_AGENDAMENTO` FOREIGN KEY (`COD_AGENDAMENTO`) REFERENCES `TB_AGENDAMENTO` (`COD_AGENDAMENTO`),
  CONSTRAINT `FK_LANCAMENTO_CARTAO_CREDITO` FOREIGN KEY (`COD_CARTAO_CREDITO`) REFERENCES `TB_CARTAO_CREDITO` (`COD_CARTAO_CREDITO`),
  CONSTRAINT `FK_LANCAMENTO_CATEGORIA` FOREIGN KEY (`COD_CATEGORIA`) REFERENCES `TB_CATEGORIA` (`COD_CATEGORIA`),
  CONSTRAINT `FK_LANCAMENTO_PARCELA` FOREIGN KEY (`COD_PARCELA`) REFERENCES `TB_PARCELA` (`COD_PARCELA`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `TB_LANCAMENTO` WRITE;
/*!40000 ALTER TABLE `TB_LANCAMENTO` DISABLE KEYS */;

INSERT INTO `TB_LANCAMENTO` (`COD_LANCAMENTO`, `COD_PARCELA`, `COD_AGENDAMENTO`, `COD_CARTAO_CREDITO`, `COD_CATEGORIA`, `COD_USUARIO`, `COD_TIPO_PAGAMENTO`, `DES_TAGS`, `VAL_PREVISTO`, `VAL_LANCAMENTO`, `DES_LANCAMENTO`, `DAT_REFERENCIA`, `DAT_LANCAMENTO`, `DAT_FATURA`, `DAT_ALTERACAO`, `IND_EXCLUIDO`)
VALUES
	(1,NULL,NULL,NULL,13,1,1,'Mãe;master;',1231.23,1231.23,'sssss','2019-02-09','2019-02-23 10:29:31',NULL,'2019-02-23 16:55:20',0),
	(2,NULL,NULL,1,18,1,3,'',0.00,0.00,'s','2019-02-23','2019-02-23 12:09:13',NULL,'2019-02-23 15:47:14',1),
	(3,NULL,NULL,1,55,1,3,'Miguel aas;Mãe;master;',0.00,0.00,'teste','2019-02-23','2019-02-23 15:33:32',NULL,'2019-02-23 15:47:06',1),
	(4,NULL,NULL,1,28,1,3,'Miguel aas;',0.00,10.00,'a','2019-02-23','2019-02-23 15:34:28',NULL,NULL,0),
	(5,NULL,NULL,1,18,1,3,'',100.00,0.00,'c','2019-02-23','2019-02-23 15:41:59',NULL,NULL,0),
	(6,NULL,NULL,NULL,32,1,2,'',200.00,40.00,'a','2019-02-23','2019-02-23 15:43:50',NULL,'2019-02-24 11:31:39',0),
	(7,33,NULL,NULL,46,1,1,'',20.00,20.00,'teste de pagamento de parcela','2019-02-24','2019-02-23 16:10:20',NULL,NULL,0),
	(8,34,NULL,NULL,46,1,1,'',20.00,20.00,'teste de pagamento de parcela 2','2019-03-19','2019-02-23 16:50:12',NULL,NULL,0),
	(9,NULL,NULL,NULL,28,1,2,'',719.76,0.00,'ritalina','2019-02-24','2019-02-24 10:40:21',NULL,NULL,0),
	(10,NULL,NULL,1,18,1,3,'',3659.40,304.95,'540km\n35 litros de gasolina aditivada','2019-01-01','2019-02-24 11:18:15',NULL,NULL,0),
	(11,NULL,NULL,1,52,1,3,'',333.33,0.00,'1','2019-02-24','2019-02-24 11:32:33',NULL,NULL,0),
	(12,NULL,NULL,1,52,1,3,'',5666.66,0.00,'6','2019-01-01','2019-02-24 11:33:58',NULL,NULL,0),
	(13,NULL,NULL,NULL,63,1,1,'',1050.00,5000.00,'a','2019-02-24','2019-02-24 13:42:13','2019-03-15',NULL,0),
	(14,NULL,NULL,NULL,63,1,1,'',1050.00,5000.00,'s','2019-02-24','2019-02-24 13:43:07','2019-03-20',NULL,0),
	(15,NULL,NULL,NULL,63,1,1,'',10500.00,11050.00,'a','2019-02-24','2019-02-24 13:46:41',NULL,NULL,0),
	(17,82,NULL,NULL,46,1,1,'',1050.00,1050.00,'asd','2019-02-28','2019-03-01 19:40:12',NULL,NULL,0),
	(26,NULL,NULL,1,48,1,1,'',304.95,8888.88,'teste de fatura','2019-03-02','2019-03-02 10:04:18','2019-02-10',NULL,0),
	(27,NULL,NULL,NULL,12,1,1,'',32.42,32.42,'','2018-12-20','2019-03-05 16:20:49',NULL,NULL,0),
	(28,NULL,NULL,NULL,57,1,1,'',4343.54,4343.54,'','2019-02-28','2019-03-06 16:37:02',NULL,NULL,0),
	(29,NULL,NULL,NULL,60,1,1,'',343.44,343.44,'cdfsd','2019-03-06','2019-03-06 16:38:03',NULL,NULL,0);

/*!40000 ALTER TABLE `TB_LANCAMENTO` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela TB_PARCELA
# ------------------------------------------------------------

DROP TABLE IF EXISTS `TB_PARCELA`;

CREATE TABLE `TB_PARCELA` (
  `COD_PARCELA` int(11) NOT NULL AUTO_INCREMENT,
  `COD_LANCAMENTO` int(11) NOT NULL,
  `NUM_PARCELA` int(11) NOT NULL,
  `DAT_PARCELA` date NOT NULL,
  `VAL_PARCELA` decimal(26,2) NOT NULL,
  PRIMARY KEY (`COD_PARCELA`),
  KEY `COD_LANCAMENTO` (`COD_LANCAMENTO`),
  CONSTRAINT `FK_PARCELA_LANCAMENTO` FOREIGN KEY (`COD_LANCAMENTO`) REFERENCES `TB_LANCAMENTO` (`COD_LANCAMENTO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `TB_PARCELA` WRITE;
/*!40000 ALTER TABLE `TB_PARCELA` DISABLE KEYS */;

INSERT INTO `TB_PARCELA` (`COD_PARCELA`, `COD_LANCAMENTO`, `NUM_PARCELA`, `DAT_PARCELA`, `VAL_PARCELA`)
VALUES
	(1,2,1,'2019-03-10',50.00),
	(2,2,2,'2019-04-10',50.01),
	(3,3,1,'2019-03-10',50.00),
	(4,3,2,'2019-04-10',50.00),
	(5,3,3,'2019-05-10',50.00),
	(6,3,4,'2019-06-10',50.00),
	(7,3,5,'2019-07-10',50.00),
	(8,3,6,'2019-08-10',50.00),
	(9,3,7,'2019-09-10',50.00),
	(10,3,8,'2019-10-10',50.00),
	(11,3,9,'2019-11-10',50.00),
	(12,3,10,'2019-12-10',50.00),
	(13,4,1,'2019-03-10',10.00),
	(14,4,2,'2019-04-10',10.00),
	(15,4,3,'2019-05-10',10.00),
	(16,4,4,'2019-06-10',10.00),
	(17,4,5,'2019-07-10',10.00),
	(18,4,6,'2019-08-10',10.00),
	(19,4,7,'2019-09-10',10.00),
	(20,4,8,'2019-10-10',10.00),
	(21,4,9,'2019-11-10',10.00),
	(22,4,10,'2019-12-10',10.00),
	(23,5,1,'2019-03-10',10.00),
	(24,5,2,'2019-04-10',10.00),
	(25,5,3,'2019-05-10',10.00),
	(26,5,4,'2019-06-10',10.00),
	(27,5,5,'2019-07-10',10.00),
	(28,5,6,'2019-08-10',10.00),
	(29,5,7,'2019-09-10',10.00),
	(30,5,8,'2019-10-10',10.00),
	(31,5,9,'2019-11-10',10.00),
	(32,5,10,'2019-12-10',10.00),
	(33,6,1,'2019-02-23',20.00),
	(34,6,2,'2019-03-23',20.00),
	(35,6,3,'2019-04-23',20.00),
	(36,6,4,'2019-05-23',20.00),
	(37,6,5,'2019-06-23',20.00),
	(38,6,6,'2019-07-23',20.00),
	(39,6,7,'2019-08-23',20.00),
	(40,6,8,'2019-09-23',20.00),
	(41,6,9,'2019-10-23',20.00),
	(42,6,10,'2019-11-23',20.00),
	(43,9,1,'2019-02-24',29.99),
	(44,9,2,'2019-03-24',29.99),
	(45,9,3,'2019-04-24',29.99),
	(46,9,4,'2019-05-24',29.99),
	(47,9,5,'2019-06-24',29.99),
	(48,9,6,'2019-07-24',29.99),
	(49,9,7,'2019-08-24',29.99),
	(50,9,8,'2019-09-24',29.99),
	(51,9,9,'2019-10-24',29.99),
	(52,9,10,'2019-11-24',29.99),
	(53,9,11,'2019-12-24',29.99),
	(54,9,12,'2020-01-24',29.99),
	(55,9,13,'2020-02-24',29.99),
	(56,9,14,'2020-03-24',29.99),
	(57,9,15,'2020-04-24',29.99),
	(58,9,16,'2020-05-24',29.99),
	(59,9,17,'2020-06-24',29.99),
	(60,9,18,'2020-07-24',29.99),
	(61,9,19,'2020-08-24',29.99),
	(62,9,20,'2020-09-24',29.99),
	(63,9,21,'2020-10-24',29.99),
	(64,9,22,'2020-11-24',29.99),
	(65,9,23,'2020-12-24',29.99),
	(66,9,24,'2021-01-24',29.99),
	(67,10,1,'2019-01-10',304.95),
	(68,10,2,'2019-02-10',304.95),
	(69,10,3,'2019-03-10',304.95),
	(70,10,4,'2019-04-01',304.95),
	(71,10,5,'2019-05-01',304.95),
	(72,10,6,'2019-06-01',304.95),
	(73,10,7,'2019-07-01',304.95),
	(74,10,8,'2019-08-01',304.95),
	(75,10,9,'2019-09-01',304.95),
	(76,10,10,'2019-10-01',304.95),
	(77,10,11,'2019-11-01',304.95),
	(78,10,12,'2019-12-01',304.95),
	(79,11,1,'2019-03-10',111.11),
	(80,11,2,'2019-04-10',111.11),
	(81,11,3,'2019-05-10',111.11),
	(82,15,1,'2019-02-24',1050.01),
	(83,15,2,'2019-03-24',1050.00),
	(84,15,3,'2019-04-24',1050.00),
	(85,15,4,'2019-05-24',1050.00),
	(86,15,5,'2019-06-24',1050.00),
	(87,15,6,'2019-07-24',1050.00),
	(88,15,7,'2019-08-24',1050.00),
	(89,15,8,'2019-09-24',1050.00),
	(90,15,9,'2019-10-24',1050.00),
	(91,15,10,'2019-11-24',1050.00);

/*!40000 ALTER TABLE `TB_PARCELA` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela TB_PERIODO
# ------------------------------------------------------------

DROP TABLE IF EXISTS `TB_PERIODO`;

CREATE TABLE `TB_PERIODO` (
  `NUM_PERIODO` int(11) NOT NULL,
  `NOM_PERIODO` varchar(100) NOT NULL,
  PRIMARY KEY (`NUM_PERIODO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `TB_PERIODO` WRITE;
/*!40000 ALTER TABLE `TB_PERIODO` DISABLE KEYS */;

INSERT INTO `TB_PERIODO` (`NUM_PERIODO`, `NOM_PERIODO`)
VALUES
	(1,'Mensal'),
	(2,'Bimestral'),
	(3,'Trimestral'),
	(6,'Semestral'),
	(12,'Anual');

/*!40000 ALTER TABLE `TB_PERIODO` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela TB_TAG
# ------------------------------------------------------------

DROP TABLE IF EXISTS `TB_TAG`;

CREATE TABLE `TB_TAG` (
  `COD_TAG` int(11) NOT NULL AUTO_INCREMENT,
  `COD_USUARIO` int(11) NOT NULL,
  `NOM_TAG` varchar(50) NOT NULL,
  `DAT_INCLUSAO` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `DAT_ALTERACAO` timestamp NULL DEFAULT NULL,
  `IND_EXCLUIDO` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`COD_TAG`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `TB_TAG` WRITE;
/*!40000 ALTER TABLE `TB_TAG` DISABLE KEYS */;

INSERT INTO `TB_TAG` (`COD_TAG`, `COD_USUARIO`, `NOM_TAG`, `DAT_INCLUSAO`, `DAT_ALTERACAO`, `IND_EXCLUIDO`)
VALUES
	(1,1,'Miguel','2018-09-19 06:43:00','2019-03-02 10:44:55',0),
	(2,1,'Mãe','2018-09-19 12:57:38',NULL,0),
	(3,1,'master','2018-09-19 19:02:52',NULL,0),
	(4,1,'teste','2018-09-19 19:31:39','2018-09-19 19:42:08',1);

/*!40000 ALTER TABLE `TB_TAG` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela vw_agenda_atual
# ------------------------------------------------------------

DROP VIEW IF EXISTS `vw_agenda_atual`;

CREATE TABLE `vw_agenda_atual` (
   `COD_USUARIO` INT(11) NOT NULL,
   `DAT_PREVISTA` DATE NULL DEFAULT NULL,
   `COD_AGENDAMENTO` INT(11) NOT NULL DEFAULT '0',
   `COD_PARCELA` INT(1) NOT NULL DEFAULT '0',
   `COD_CARTAO_CREDITO` INT(1) NOT NULL DEFAULT '0',
   `COD_CATEGORIA` INT(11) NOT NULL,
   `DES_CATEGORIA` VARCHAR(500) NOT NULL,
   `VAL_PREVISTO` DECIMAL(49) NULL DEFAULT NULL,
   `DAT_PAGAMENTO` DATE NULL DEFAULT NULL,
   `VAL_PAGO` DECIMAL(26) NULL DEFAULT '0.00'
) ENGINE=MyISAM;



# Dump da tabela vw_agendamentos
# ------------------------------------------------------------

DROP VIEW IF EXISTS `vw_agendamentos`;

CREATE TABLE `vw_agendamentos` (
   `COD_USUARIO` INT(11) NOT NULL,
   `NOM_PERIODO` VARCHAR(100) NOT NULL,
   `COD_AGENDAMENTO` INT(11) NOT NULL DEFAULT '0',
   `NOM_AGENDAMENTO` VARCHAR(250) NOT NULL,
   `DAT_PAGAMENTO` DATE NULL DEFAULT NULL,
   `VAL_PAGO` DECIMAL(26) NULL DEFAULT '0.00',
   `COD_CATEGORIA` INT(11) NOT NULL,
   `DES_CATEGORIA` VARCHAR(500) NOT NULL,
   `VAL_PREVISTO` DECIMAL(49) NULL DEFAULT NULL,
   `DAT_PREVISTA` DATE NULL DEFAULT NULL,
   `DIAS` BIGINT(21) NULL DEFAULT NULL
) ENGINE=MyISAM;



# Dump da tabela vw_despesas_receitas
# ------------------------------------------------------------

DROP VIEW IF EXISTS `vw_despesas_receitas`;

CREATE TABLE `vw_despesas_receitas` (
   `COD_USUARIO` INT(11) NOT NULL DEFAULT '0',
   `DAT_COMPETENCIA` DATE NULL DEFAULT NULL,
   `VAL_DESPESA_PREVISTA` DECIMAL(48) NULL DEFAULT NULL,
   `VAL_DESPESA_PAGA` DECIMAL(48) NULL DEFAULT NULL,
   `VAL_RECEITA_PREVISTA` DECIMAL(48) NULL DEFAULT NULL,
   `VAL_RECEITA_PAGA` DECIMAL(48) NULL DEFAULT NULL
) ENGINE=MyISAM;



# Dump da tabela vw_faturas
# ------------------------------------------------------------

DROP VIEW IF EXISTS `vw_faturas`;

CREATE TABLE `vw_faturas` (
   `COD_USUARIO` INT(11) NOT NULL,
   `COD_CARTAO_CREDITO` INT(11) NOT NULL DEFAULT '0',
   `NOM_BANDEIRA` VARCHAR(50) NOT NULL,
   `NOM_CARTAO_CREDITO` VARCHAR(100) NOT NULL,
   `DAT_FATURA` DATE NULL DEFAULT NULL,
   `DAT_REFERENCIA` DATE NOT NULL,
   `VAL_PREVISTO` DECIMAL(26) NOT NULL DEFAULT '0.00',
   `VAL_LANCAMENTO` DECIMAL(26) NOT NULL DEFAULT '0.00',
   `QTD_PARCELAS` BIGINT(21) NOT NULL DEFAULT '0',
   `VAL_PARCELAS` DECIMAL(48) NULL DEFAULT NULL
) ENGINE=MyISAM;



# Dump da tabela vw_faturas_datas
# ------------------------------------------------------------

DROP VIEW IF EXISTS `vw_faturas_datas`;

CREATE TABLE `vw_faturas_datas` (
   `COD_USUARIO` INT(11) NOT NULL DEFAULT '0',
   `COD_CARTAO_CREDITO` INT(11) NOT NULL DEFAULT '0',
   `DAT_FATURA` DATE NULL DEFAULT NULL,
   `DAT_REFERENCIA` DATE NULL DEFAULT NULL,
   `VAL_LANCAMENTO` DECIMAL(26) NULL DEFAULT '0.00'
) ENGINE=MyISAM;



# Dump da tabela vw_faturas_previstas_realizadas
# ------------------------------------------------------------

DROP VIEW IF EXISTS `vw_faturas_previstas_realizadas`;

CREATE TABLE `vw_faturas_previstas_realizadas` (
   `COD_USUARIO` INT(11) NOT NULL DEFAULT '0',
   `COD_CARTAO_CREDITO` INT(11) NOT NULL DEFAULT '0',
   `NOM_BANDEIRA` VARCHAR(50) NOT NULL,
   `NOM_CARTAO_CREDITO` VARCHAR(100) NOT NULL,
   `DAT_FATURA` DATE NULL DEFAULT NULL,
   `DAT_REFERENCIA` DATE NULL DEFAULT NULL,
   `VAL_LANCAMENTO` DECIMAL(26) NULL DEFAULT '0.00',
   `VAL_PARCELAS_PENDENTES` DECIMAL(48) NULL DEFAULT NULL,
   `QTD_PARCELAS_PENDENTES` BIGINT(21) NOT NULL DEFAULT '0'
) ENGINE=MyISAM;



# Dump da tabela vw_lancamentos
# ------------------------------------------------------------

DROP VIEW IF EXISTS `vw_lancamentos`;

CREATE TABLE `vw_lancamentos` (
   `COD_USUARIO` INT(11) NOT NULL DEFAULT '0',
   `DES_LANCAMENTOS` VARCHAR(15) NOT NULL DEFAULT '',
   `COD_TIPO` BIGINT(20) NOT NULL DEFAULT '0',
   `VAL_PREVISTO` DECIMAL(65) NULL DEFAULT NULL,
   `VAL_PAGO` DECIMAL(48) NULL DEFAULT NULL
) ENGINE=MyISAM;



# Dump da tabela vw_media_agendamentos
# ------------------------------------------------------------

DROP VIEW IF EXISTS `vw_media_agendamentos`;

CREATE TABLE `vw_media_agendamentos` (
   `COD_AGENDAMENTO` INT(11) NULL DEFAULT NULL,
   `NUM_QTD` BIGINT(21) NOT NULL DEFAULT '0',
   `VAL_TOTAL` DECIMAL(48) NULL DEFAULT NULL,
   `VAL_MEDIA` DECIMAL(49) NULL DEFAULT NULL
) ENGINE=MyISAM;



# Dump da tabela vw_parcelas
# ------------------------------------------------------------

DROP VIEW IF EXISTS `vw_parcelas`;

CREATE TABLE `vw_parcelas` (
   `COD_USUARIO` INT(11) NOT NULL,
   `COD_PARCELA` INT(11) NOT NULL DEFAULT '0',
   `DAT_PREVISTA` DATE NOT NULL,
   `VAL_PREVISTO` DECIMAL(26) NOT NULL,
   `DAT_PAGAMENTO` DATE NOT NULL,
   `VAL_PAGO` DECIMAL(26) NOT NULL DEFAULT '0.00',
   `DIAS` BIGINT(21) NULL DEFAULT NULL,
   `DES_CATEGORIA` VARCHAR(500) NOT NULL,
   `COD_CATEGORIA` INT(2) NOT NULL DEFAULT '0'
) ENGINE=MyISAM;



# Dump da tabela vw_parcelas_sem_fatura
# ------------------------------------------------------------

DROP VIEW IF EXISTS `vw_parcelas_sem_fatura`;

CREATE TABLE `vw_parcelas_sem_fatura` (
   `COD_USUARIO` INT(11) NOT NULL,
   `COD_CARTAO_CREDITO` INT(11) NULL DEFAULT NULL,
   `COD_PARCELA` INT(11) NOT NULL DEFAULT '0',
   `NOM_BANDEIRA` VARCHAR(50) NOT NULL,
   `NOM_CARTAO_CREDITO` VARCHAR(100) NOT NULL,
   `NOM_CATEGORIA` VARCHAR(500) NOT NULL,
   `DAT_PARCELA` DATE NOT NULL,
   `VAL_PARCELA` DECIMAL(26) NOT NULL
) ENGINE=MyISAM;



# Dump da tabela vw_proximas_atividades
# ------------------------------------------------------------

DROP VIEW IF EXISTS `vw_proximas_atividades`;

CREATE TABLE `vw_proximas_atividades` (
   `COD_USUARIO` INT(11) NOT NULL,
   `DAT_PREVISTA` DATE NULL DEFAULT NULL,
   `COD_AGENDAMENTO` INT(11) NOT NULL DEFAULT '0',
   `COD_PARCELA` INT(1) NOT NULL DEFAULT '0',
   `COD_CARTAO_CREDITO` INT(1) NOT NULL DEFAULT '0',
   `NOME` VARCHAR(250) NOT NULL,
   `COD_CATEGORIA` INT(11) NOT NULL,
   `DES_CATEGORIA` VARCHAR(500) NOT NULL,
   `VAL_PREVISTO` DECIMAL(49) NULL DEFAULT NULL,
   `DAT_PAGAMENTO` DATE NULL DEFAULT NULL,
   `VAL_PAGO` DECIMAL(26) NULL DEFAULT '0.00',
   `DIAS` BIGINT(21) NULL DEFAULT NULL
) ENGINE=MyISAM;



# Dump da tabela vw_relacao_lancamento
# ------------------------------------------------------------

DROP VIEW IF EXISTS `vw_relacao_lancamento`;

CREATE TABLE `vw_relacao_lancamento` (
   `COD_USUARIO` INT(11) NOT NULL,
   `COD_LANCAMENTO` INT(11) NOT NULL DEFAULT '0',
   `COD_LANCAMENTO_PARCELA` INT(11) NULL DEFAULT NULL,
   `ANO_MES` VARCHAR(6) NULL DEFAULT NULL,
   `COD_TIPO` INT(1) NOT NULL DEFAULT '0',
   `DES_CATEGORIA` TEXT NULL DEFAULT NULL,
   `NUM_PARCELA` INT(11) NULL DEFAULT NULL,
   `NOM_AGENDAMENTO` VARCHAR(250) NULL DEFAULT NULL,
   `DAT_LANCAMENTO` VARCHAR(21) NULL DEFAULT NULL,
   `DAT_REFERENCIA` VARCHAR(10) NULL DEFAULT NULL,
   `VAL_PREVISTO` DECIMAL(26) NOT NULL DEFAULT '0.00',
   `VAL_PAGO` DECIMAL(26) NOT NULL DEFAULT '0.00'
) ENGINE=MyISAM;



# Dump da tabela vw_relatorio
# ------------------------------------------------------------

DROP VIEW IF EXISTS `vw_relatorio`;

CREATE TABLE `vw_relatorio` (
   `COD_USUARIO` INT(11) NOT NULL,
   `COD_LANCAMENTO` INT(11) NOT NULL DEFAULT '0',
   `DAT_REFERENCIA` DATE NOT NULL,
   `DAT_LANCAMENTO` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
   `ANO_MES` VARCHAR(7) NULL DEFAULT NULL,
   `VAL_PREVISTO` DECIMAL(26) NOT NULL DEFAULT '0.00',
   `VAL_LANCAMENTO` DECIMAL(26) NOT NULL DEFAULT '0.00',
   `DES_TAGS` VARCHAR(4000) NULL DEFAULT NULL,
   `COD_CATEGORIA` INT(11) NOT NULL,
   `NOM_CATEGORIA` VARCHAR(500) NOT NULL,
   `COD_GRUPO` INT(11) NOT NULL,
   `NOM_GRUPO` VARCHAR(100) NOT NULL,
   `COD_LANCAMENTO_PARCELA` INT(11) NULL DEFAULT NULL,
   `COD_PARCELA` INT(11) NULL DEFAULT '0',
   `NUM_PARCELA` INT(11) NULL DEFAULT NULL,
   `DES_TAGS_PARCELA` VARCHAR(4000) NULL DEFAULT NULL,
   `COD_CATEGORIA_PARCELA` INT(11) NULL DEFAULT NULL,
   `NOM_CATEGORIA_PARCELA` VARCHAR(500) NULL DEFAULT NULL,
   `COD_GRUPO_PARCELA` INT(11) NULL DEFAULT NULL,
   `NOM_GRUPO_PARCELA` VARCHAR(100) NULL DEFAULT NULL,
   `COD_AGENDAMENTO` INT(11) NULL DEFAULT '0',
   `NOM_AGENDAMENTO` VARCHAR(250) NULL DEFAULT NULL,
   `COD_CARTAO_CREDITO` INT(11) NULL DEFAULT '0',
   `NOM_CARTAO_CREDITO` VARCHAR(153) NULL DEFAULT NULL,
   `COD_TIPO` INT(1) NOT NULL DEFAULT '0'
) ENGINE=MyISAM;



# Dump da tabela vw_resumo_mes
# ------------------------------------------------------------

DROP VIEW IF EXISTS `vw_resumo_mes`;

CREATE TABLE `vw_resumo_mes` (
   `COD_USUARIO` INT(11) NOT NULL DEFAULT '0',
   `DES_LANCAMENTOS` VARCHAR(15) NOT NULL DEFAULT '',
   `COD_TIPO` BIGINT(20) NOT NULL DEFAULT '0',
   `VAL_PREVISTO` DECIMAL(65) NULL DEFAULT NULL,
   `VAL_PAGO` DECIMAL(48) NULL DEFAULT NULL
) ENGINE=MyISAM;



# Dump da tabela vw_ultimas_atividades
# ------------------------------------------------------------

DROP VIEW IF EXISTS `vw_ultimas_atividades`;

CREATE TABLE `vw_ultimas_atividades` (
   `COD_USUARIO` INT(11) NOT NULL,
   `ANO_MES` VARCHAR(7) NULL DEFAULT NULL,
   `DAT_REFERENCIA` DATE NOT NULL,
   `DAT_LANCAMENTO` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
   `NUM_DIAS` BIGINT(21) NULL DEFAULT NULL,
   `NUM_HORAS` BIGINT(21) NULL DEFAULT NULL,
   `NUM_MINUTOS` BIGINT(21) NULL DEFAULT NULL,
   `VAL_LANCAMENTO` DECIMAL(26) NOT NULL DEFAULT '0.00',
   `DES_CATEGORIA` TEXT NULL DEFAULT NULL
) ENGINE=MyISAM;





# Replace placeholder table for vw_lancamentos with correct view syntax
# ------------------------------------------------------------

DROP TABLE `vw_lancamentos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_lancamentos`
AS SELECT
   `vw_agendamentos`.`COD_USUARIO` AS `COD_USUARIO`,'Agendamentos' AS `DES_LANCAMENTOS`,1 AS `COD_TIPO`,sum((case when isnull(`vw_agendamentos`.`VAL_PREVISTO`) then 0 else `vw_agendamentos`.`VAL_PREVISTO` end)) AS `VAL_PREVISTO`,sum((case when isnull(`vw_agendamentos`.`VAL_PAGO`) then 0 else `vw_agendamentos`.`VAL_PAGO` end)) AS `VAL_PAGO`
FROM `vw_agendamentos` where (date_format(curdate(),'%Y%m') = date_format(`vw_agendamentos`.`DAT_PREVISTA`,'%Y%m')) group by `vw_agendamentos`.`COD_USUARIO` union all select `LANCAMENTO`.`COD_USUARIO` AS `COD_USUARIO`,'Despesas Gerais' AS `DES_LANCAMENTOS`,3 AS `COD_TIPO`,sum((case when isnull(`LANCAMENTO`.`VAL_PREVISTO`) then 0 else `LANCAMENTO`.`VAL_PREVISTO` end)) AS `VAL_PREVISTO`,sum(`LANCAMENTO`.`VAL_LANCAMENTO`) AS `VAL_PAGO` from (`tb_lancamento` `LANCAMENTO` join `tb_categoria` `CATEGORIA` on((`CATEGORIA`.`COD_CATEGORIA` = `LANCAMENTO`.`COD_CATEGORIA`))) where (isnull(`LANCAMENTO`.`COD_AGENDAMENTO`) and isnull(`LANCAMENTO`.`COD_PARCELA`) and (`CATEGORIA`.`COD_GRUPO` <> 9) and (`CATEGORIA`.`COD_CATEGORIA` <> 48) and (date_format(curdate(),'%Y%m') = date_format(`LANCAMENTO`.`DAT_REFERENCIA`,'%Y%m'))) group by `LANCAMENTO`.`COD_USUARIO` union all select `LANCAMENTO`.`COD_USUARIO` AS `COD_USUARIO`,'Receitas' AS `DES_LANCAMENTOS`,4 AS `COD_TIPO`,sum((case when isnull(`LANCAMENTO`.`VAL_PREVISTO`) then 0 else `LANCAMENTO`.`VAL_PREVISTO` end)) AS `VAL_PREVISTO`,sum(`LANCAMENTO`.`VAL_LANCAMENTO`) AS `VAL_PAGO` from (`tb_lancamento` `LANCAMENTO` join `tb_categoria` `CATEGORIA` on((`CATEGORIA`.`COD_CATEGORIA` = `LANCAMENTO`.`COD_CATEGORIA`))) where (isnull(`LANCAMENTO`.`COD_AGENDAMENTO`) and isnull(`LANCAMENTO`.`COD_PARCELA`) and (`CATEGORIA`.`COD_GRUPO` = 9) and (date_format(curdate(),'%Y%m') = date_format(`LANCAMENTO`.`DAT_REFERENCIA`,'%Y%m'))) group by `LANCAMENTO`.`COD_USUARIO` union all select `LANCAMENTO`.`COD_USUARIO` AS `COD_USUARIO`,'Faturas' AS `DES_LANCAMENTOS`,5 AS `COD_TIPO`,sum((case when isnull(`LANCAMENTO`.`VAL_PREVISTO`) then 0 else `LANCAMENTO`.`VAL_PREVISTO` end)) AS `VAL_PREVISTO`,sum(`LANCAMENTO`.`VAL_LANCAMENTO`) AS `VAL_PAGO` from `tb_lancamento` `LANCAMENTO` where (isnull(`LANCAMENTO`.`COD_AGENDAMENTO`) and isnull(`LANCAMENTO`.`COD_PARCELA`) and (`LANCAMENTO`.`COD_CARTAO_CREDITO` is not null) and (`LANCAMENTO`.`COD_CATEGORIA` = 48) and (date_format(curdate(),'%Y%m') = date_format(`LANCAMENTO`.`DAT_REFERENCIA`,'%Y%m'))) group by `LANCAMENTO`.`COD_USUARIO`;


# Replace placeholder table for vw_parcelas with correct view syntax
# ------------------------------------------------------------

DROP TABLE `vw_parcelas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_parcelas`
AS SELECT
   `LANCAMENTO`.`COD_USUARIO` AS `COD_USUARIO`,
   `PARCELA`.`COD_PARCELA` AS `COD_PARCELA`,
   `PARCELA`.`DAT_PARCELA` AS `DAT_PREVISTA`,
   `PARCELA`.`VAL_PARCELA` AS `VAL_PREVISTO`,
   `LANCAMENTO_PAGAMENTO`.`DAT_REFERENCIA` AS `DAT_PAGAMENTO`,
   `LANCAMENTO_PAGAMENTO`.`VAL_LANCAMENTO` AS `VAL_PAGO`,timestampdiff(DAY,now(),`PARCELA`.`DAT_PARCELA`) AS `DIAS`,
   `CATEGORIA`.`NOM_CATEGORIA` AS `DES_CATEGORIA`,46 AS `COD_CATEGORIA`
FROM (((`tb_parcela` `PARCELA` join `tb_lancamento` `LANCAMENTO` on((`LANCAMENTO`.`COD_LANCAMENTO` = `PARCELA`.`COD_LANCAMENTO`))) join `tb_categoria` `CATEGORIA` on((`CATEGORIA`.`COD_CATEGORIA` = `LANCAMENTO`.`COD_CATEGORIA`))) join `tb_lancamento` `LANCAMENTO_PAGAMENTO` on((`LANCAMENTO_PAGAMENTO`.`COD_PARCELA` = `PARCELA`.`COD_PARCELA`))) where (isnull(`LANCAMENTO`.`COD_CARTAO_CREDITO`) and ((date_format(curdate(),'%Y%m') = date_format(`PARCELA`.`DAT_PARCELA`,'%Y%m')) or ((`PARCELA`.`DAT_PARCELA` < concat(date_format(curdate(),'%Y-%m'),'-01')) and isnull(`LANCAMENTO_PAGAMENTO`.`DAT_REFERENCIA`))));


# Replace placeholder table for vw_proximas_atividades with correct view syntax
# ------------------------------------------------------------

DROP TABLE `vw_proximas_atividades`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_proximas_atividades`
AS SELECT
   `vw_agendamentos`.`COD_USUARIO` AS `COD_USUARIO`,
   `vw_agendamentos`.`DAT_PREVISTA` AS `DAT_PREVISTA`,
   `vw_agendamentos`.`COD_AGENDAMENTO` AS `COD_AGENDAMENTO`,0 AS `COD_PARCELA`,0 AS `COD_CARTAO_CREDITO`,
   `vw_agendamentos`.`NOM_AGENDAMENTO` AS `NOME`,
   `vw_agendamentos`.`COD_CATEGORIA` AS `COD_CATEGORIA`,
   `vw_agendamentos`.`DES_CATEGORIA` AS `DES_CATEGORIA`,
   `vw_agendamentos`.`VAL_PREVISTO` AS `VAL_PREVISTO`,
   `vw_agendamentos`.`DAT_PAGAMENTO` AS `DAT_PAGAMENTO`,
   `vw_agendamentos`.`VAL_PAGO` AS `VAL_PAGO`,
   `vw_agendamentos`.`DIAS` AS `DIAS`
FROM `vw_agendamentos` where isnull(`vw_agendamentos`.`DAT_PAGAMENTO`);


# Replace placeholder table for vw_faturas_previstas_realizadas with correct view syntax
# ------------------------------------------------------------

DROP TABLE `vw_faturas_previstas_realizadas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_faturas_previstas_realizadas`
AS SELECT
   `faturas_datas`.`COD_USUARIO` AS `COD_USUARIO`,
   `faturas_datas`.`COD_CARTAO_CREDITO` AS `COD_CARTAO_CREDITO`,
   `CARTAO_CREDITO`.`NOM_BANDEIRA` AS `NOM_BANDEIRA`,
   `CARTAO_CREDITO`.`NOM_CARTAO_CREDITO` AS `NOM_CARTAO_CREDITO`,
   `faturas_datas`.`DAT_FATURA` AS `DAT_FATURA`,
   `faturas`.`DAT_REFERENCIA` AS `DAT_REFERENCIA`,
   `faturas`.`VAL_LANCAMENTO` AS `VAL_LANCAMENTO`,round(sum((case when isnull(`parcelas_sem_fatura`.`VAL_PARCELA`) then 0 else `parcelas_sem_fatura`.`VAL_PARCELA` end)),2) AS `VAL_PARCELAS_PENDENTES`,count(`parcelas_sem_fatura`.`COD_PARCELA`) AS `QTD_PARCELAS_PENDENTES`
FROM (((`quaemoco_scaf`.`vw_faturas_datas` `FATURAS_DATAS` join `quaemoco_scaf`.`tb_cartao_credito` `CARTAO_CREDITO` on((`CARTAO_CREDITO`.`COD_CARTAO_CREDITO` = `faturas_datas`.`COD_CARTAO_CREDITO`))) left join `quaemoco_scaf`.`vw_parcelas_sem_fatura` `PARCELAS_SEM_FATURA` on(((`parcelas_sem_fatura`.`COD_CARTAO_CREDITO` = `faturas_datas`.`COD_CARTAO_CREDITO`) and (`parcelas_sem_fatura`.`DAT_PARCELA` = `faturas_datas`.`DAT_FATURA`)))) left join `quaemoco_scaf`.`vw_faturas` `FATURAS` on(((`faturas`.`COD_CARTAO_CREDITO` = `faturas_datas`.`COD_CARTAO_CREDITO`) and (`faturas`.`DAT_FATURA` = `faturas_datas`.`DAT_FATURA`)))) group by `faturas_datas`.`COD_USUARIO`,`faturas_datas`.`COD_CARTAO_CREDITO`,`CARTAO_CREDITO`.`NOM_BANDEIRA`,`CARTAO_CREDITO`.`NOM_CARTAO_CREDITO`,`faturas_datas`.`DAT_FATURA`,`faturas`.`DAT_REFERENCIA`,`faturas`.`VAL_LANCAMENTO` order by `faturas_datas`.`DAT_FATURA`,`faturas_datas`.`COD_CARTAO_CREDITO`;


# Replace placeholder table for vw_relacao_lancamento with correct view syntax
# ------------------------------------------------------------

DROP TABLE `vw_relacao_lancamento`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_relacao_lancamento`
AS SELECT
   `LANCAMENTO`.`COD_USUARIO` AS `COD_USUARIO`,
   `LANCAMENTO`.`COD_LANCAMENTO` AS `COD_LANCAMENTO`,
   `PARCELA`.`COD_LANCAMENTO` AS `COD_LANCAMENTO_PARCELA`,date_format(`LANCAMENTO`.`DAT_LANCAMENTO`,'%Y%m') AS `ANO_MES`,(case when (`LANCAMENTO`.`COD_AGENDAMENTO` is not null) then 1 when (`LANCAMENTO`.`COD_PARCELA` is not null) then 2 when ((`GRUPO`.`COD_GRUPO` <> 9) and (`LANCAMENTO`.`COD_CATEGORIA` <> 48)) then 3 when (`GRUPO`.`COD_GRUPO` = 9) then 4 when (`LANCAMENTO`.`COD_CATEGORIA` = 48) then 5 else 3 end) AS `COD_TIPO`,(case when (`LANCAMENTO`.`COD_PARCELA` is not null) then `CATEGORIA_PARCELA`.`NOM_CATEGORIA` when (`LANCAMENTO`.`COD_CARTAO_CREDITO` is not null) then concat(`CATEGORIA`.`NOM_CATEGORIA`,' (',`CARTAO_CREDITO`.`NOM_BANDEIRA`,' - ',`CARTAO_CREDITO`.`NOM_CARTAO_CREDITO`,')') else `CATEGORIA`.`NOM_CATEGORIA` end) AS `DES_CATEGORIA`,
   `PARCELA`.`NUM_PARCELA` AS `NUM_PARCELA`,
   `AGENDAMENTO`.`NOM_AGENDAMENTO` AS `NOM_AGENDAMENTO`,date_format(`LANCAMENTO`.`DAT_LANCAMENTO`,'%d/%m/%Y %H:%i') AS `DAT_LANCAMENTO`,date_format(`LANCAMENTO`.`DAT_REFERENCIA`,'%d/%m/%Y') AS `DAT_REFERENCIA`,
   `LANCAMENTO`.`VAL_PREVISTO` AS `VAL_PREVISTO`,(case when isnull(`LANCAMENTO`.`COD_CARTAO_CREDITO`) then `LANCAMENTO`.`VAL_LANCAMENTO` else `LANCAMENTO`.`VAL_PREVISTO` end) AS `VAL_PAGO`
FROM ((((((((`tb_lancamento` `LANCAMENTO` join `tb_categoria` `CATEGORIA` on((`CATEGORIA`.`COD_CATEGORIA` = `LANCAMENTO`.`COD_CATEGORIA`))) join `tb_grupo` `GRUPO` on((`GRUPO`.`COD_GRUPO` = `CATEGORIA`.`COD_GRUPO`))) left join `tb_agendamento` `AGENDAMENTO` on((`AGENDAMENTO`.`COD_AGENDAMENTO` = `LANCAMENTO`.`COD_AGENDAMENTO`))) left join `tb_parcela` `PARCELA` on((`PARCELA`.`COD_PARCELA` = `LANCAMENTO`.`COD_PARCELA`))) left join `tb_lancamento` `LANCAMENTO_PARCELA` on((`LANCAMENTO_PARCELA`.`COD_LANCAMENTO` = `PARCELA`.`COD_LANCAMENTO`))) left join `tb_categoria` `CATEGORIA_PARCELA` on((`CATEGORIA_PARCELA`.`COD_CATEGORIA` = `LANCAMENTO_PARCELA`.`COD_CATEGORIA`))) left join `tb_grupo` `GRUPO_PARCELA` on((`GRUPO_PARCELA`.`COD_GRUPO` = `CATEGORIA_PARCELA`.`COD_GRUPO`))) left join `tb_cartao_credito` `CARTAO_CREDITO` on((`CARTAO_CREDITO`.`COD_CARTAO_CREDITO` = `LANCAMENTO`.`COD_CARTAO_CREDITO`))) order by `LANCAMENTO`.`DAT_REFERENCIA`,(case when (`LANCAMENTO`.`COD_PARCELA` is not null) then `CATEGORIA_PARCELA`.`NOM_CATEGORIA` when (`LANCAMENTO`.`COD_CARTAO_CREDITO` is not null) then concat(`CATEGORIA`.`NOM_CATEGORIA`,' (',`CARTAO_CREDITO`.`NOM_BANDEIRA`,' - ',`CARTAO_CREDITO`.`NOM_CARTAO_CREDITO`,')') else `CATEGORIA`.`NOM_CATEGORIA` end),`LANCAMENTO`.`COD_LANCAMENTO`;


# Replace placeholder table for vw_parcelas_sem_fatura with correct view syntax
# ------------------------------------------------------------

DROP TABLE `vw_parcelas_sem_fatura`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_parcelas_sem_fatura`
AS SELECT
   `LANCAMENTO`.`COD_USUARIO` AS `COD_USUARIO`,
   `LANCAMENTO`.`COD_CARTAO_CREDITO` AS `COD_CARTAO_CREDITO`,
   `PARCELA`.`COD_PARCELA` AS `COD_PARCELA`,
   `CARTAO_CREDITO`.`NOM_BANDEIRA` AS `NOM_BANDEIRA`,
   `CARTAO_CREDITO`.`NOM_CARTAO_CREDITO` AS `NOM_CARTAO_CREDITO`,
   `CATEGORIA`.`NOM_CATEGORIA` AS `NOM_CATEGORIA`,
   `PARCELA`.`DAT_PARCELA` AS `DAT_PARCELA`,
   `PARCELA`.`VAL_PARCELA` AS `VAL_PARCELA`
FROM (((((`tb_parcela` `PARCELA` join `tb_lancamento` `LANCAMENTO` on((`LANCAMENTO`.`COD_LANCAMENTO` = `PARCELA`.`COD_LANCAMENTO`))) join `tb_categoria` `CATEGORIA` on((`CATEGORIA`.`COD_CATEGORIA` = `LANCAMENTO`.`COD_CATEGORIA`))) join `tb_cartao_credito` `CARTAO_CREDITO` on((`CARTAO_CREDITO`.`COD_CARTAO_CREDITO` = `LANCAMENTO`.`COD_CARTAO_CREDITO`))) left join `tb_lancamento` `LANCAMENTO_PARCELA` on((`LANCAMENTO_PARCELA`.`COD_LANCAMENTO` = `PARCELA`.`COD_LANCAMENTO`))) left join `rl_lancamento_parcela` `RL` on((`RL`.`COD_PARCELA` = `PARCELA`.`COD_PARCELA`))) where isnull(`RL`.`COD_PARCELA`);


# Replace placeholder table for vw_faturas_datas with correct view syntax
# ------------------------------------------------------------

DROP TABLE `vw_faturas_datas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_faturas_datas`
AS SELECT
   `f`.`COD_USUARIO` AS `COD_USUARIO`,
   `f`.`COD_CARTAO_CREDITO` AS `COD_CARTAO_CREDITO`,
   `f`.`DAT_FATURA` AS `DAT_FATURA`,
   `L`.`DAT_REFERENCIA` AS `DAT_REFERENCIA`,
   `L`.`VAL_LANCAMENTO` AS `VAL_LANCAMENTO`
FROM (((select `quaemoco_scaf`.`tb_cartao_credito`.`COD_CARTAO_CREDITO` AS `COD_CARTAO_CREDITO`,`quaemoco_scaf`.`tb_cartao_credito`.`COD_USUARIO` AS `COD_USUARIO`,str_to_date(concat(date_format((curdate() + interval -(2) month),'%Y-%m-'),convert(concat((case when (`quaemoco_scaf`.`tb_cartao_credito`.`NUM_DIA_VENCIMENTO` < 10) then '0' else '' end),`quaemoco_scaf`.`tb_cartao_credito`.`NUM_DIA_VENCIMENTO`) using utf8)),'%Y-%m-%d') AS `DAT_FATURA` from `quaemoco_scaf`.`tb_cartao_credito`) union all select `quaemoco_scaf`.`tb_cartao_credito`.`COD_CARTAO_CREDITO` AS `COD_CARTAO_CREDITO`,`quaemoco_scaf`.`tb_cartao_credito`.`COD_USUARIO` AS `COD_USUARIO`,str_to_date(concat(date_format((curdate() + interval -(1) month),'%Y-%m-'),convert(concat((case when (`quaemoco_scaf`.`tb_cartao_credito`.`NUM_DIA_VENCIMENTO` < 10) then '0' else '' end),`quaemoco_scaf`.`tb_cartao_credito`.`NUM_DIA_VENCIMENTO`) using utf8)),'%Y-%m-%d') AS `DAT_FATURA` from `quaemoco_scaf`.`tb_cartao_credito` union all select `quaemoco_scaf`.`tb_cartao_credito`.`COD_CARTAO_CREDITO` AS `COD_CARTAO_CREDITO`,`quaemoco_scaf`.`tb_cartao_credito`.`COD_USUARIO` AS `COD_USUARIO`,str_to_date(concat(date_format(curdate(),'%Y-%m-'),convert(concat((case when (`quaemoco_scaf`.`tb_cartao_credito`.`NUM_DIA_VENCIMENTO` < 10) then '0' else '' end),`quaemoco_scaf`.`tb_cartao_credito`.`NUM_DIA_VENCIMENTO`) using utf8)),'%Y-%m-%d') AS `DAT_FATURA` from `quaemoco_scaf`.`tb_cartao_credito` union all select `quaemoco_scaf`.`tb_cartao_credito`.`COD_CARTAO_CREDITO` AS `COD_CARTAO_CREDITO`,`quaemoco_scaf`.`tb_cartao_credito`.`COD_USUARIO` AS `COD_USUARIO`,str_to_date(concat(date_format((curdate() + interval 1 month),'%Y-%m-'),convert(concat((case when (`quaemoco_scaf`.`tb_cartao_credito`.`NUM_DIA_VENCIMENTO` < 10) then '0' else '' end),`quaemoco_scaf`.`tb_cartao_credito`.`NUM_DIA_VENCIMENTO`) using utf8)),'%Y-%m-%d') AS `DAT_FATURA` from `quaemoco_scaf`.`tb_cartao_credito`) `F` left join `quaemoco_scaf`.`tb_lancamento` `L` on(((`L`.`COD_CARTAO_CREDITO` = `f`.`COD_CARTAO_CREDITO`) and (`L`.`DAT_FATURA` = `f`.`DAT_FATURA`) and (`L`.`COD_CATEGORIA` = 48) and (`L`.`IND_EXCLUIDO` = 0))));


# Replace placeholder table for vw_agendamentos with correct view syntax
# ------------------------------------------------------------

DROP TABLE `vw_agendamentos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_agendamentos`
AS SELECT
   `AGENDAMENTO`.`COD_USUARIO` AS `COD_USUARIO`,
   `PERIODO`.`NOM_PERIODO` AS `NOM_PERIODO`,
   `AGENDAMENTO`.`COD_AGENDAMENTO` AS `COD_AGENDAMENTO`,
   `AGENDAMENTO`.`NOM_AGENDAMENTO` AS `NOM_AGENDAMENTO`,
   `LANCAMENTO`.`DAT_REFERENCIA` AS `DAT_PAGAMENTO`,
   `LANCAMENTO`.`VAL_LANCAMENTO` AS `VAL_PAGO`,
   `CATEGORIA`.`COD_CATEGORIA` AS `COD_CATEGORIA`,
   `CATEGORIA`.`NOM_CATEGORIA` AS `DES_CATEGORIA`,(case when isnull(`vw`.`VAL_MEDIA`) then 0.00 else `vw`.`VAL_MEDIA` end) AS `VAL_PREVISTO`,(`AGENDAMENTO`.`DAT_INICIO` + interval (`PERIODO`.`NUM_PERIODO` * round((period_diff(date_format(curdate(),'%Y%m'),date_format(`AGENDAMENTO`.`DAT_INICIO`,'%Y%m')) / `PERIODO`.`NUM_PERIODO`),0)) month) AS `DAT_PREVISTA`,timestampdiff(DAY,now(),(`AGENDAMENTO`.`DAT_INICIO` + interval (`PERIODO`.`NUM_PERIODO` * round((period_diff(date_format(curdate(),'%Y%m'),date_format(`AGENDAMENTO`.`DAT_INICIO`,'%Y%m')) / `PERIODO`.`NUM_PERIODO`),0)) month)) AS `DIAS`
FROM ((((`tb_agendamento` `AGENDAMENTO` join `tb_categoria` `CATEGORIA` on((`CATEGORIA`.`COD_CATEGORIA` = `AGENDAMENTO`.`COD_CATEGORIA`))) join `tb_periodo` `PERIODO` on((`PERIODO`.`NUM_PERIODO` = `AGENDAMENTO`.`NUM_PERIODO`))) left join `tb_lancamento` `LANCAMENTO` on(((`LANCAMENTO`.`COD_AGENDAMENTO` = `AGENDAMENTO`.`COD_AGENDAMENTO`) and (date_format(`LANCAMENTO`.`DAT_REFERENCIA`,'%Y%m') = date_format(curdate(),'%Y%m')) and (`LANCAMENTO`.`COD_LANCAMENTO` = (select max(`L2`.`COD_LANCAMENTO`) from `tb_lancamento` `L2` where ((`L2`.`COD_AGENDAMENTO` = `AGENDAMENTO`.`COD_AGENDAMENTO`) and (date_format(`L2`.`DAT_REFERENCIA`,'%Y%m') = date_format(curdate(),'%Y%m')))))))) left join `vw_media_agendamentos` `VW` on((`vw`.`COD_AGENDAMENTO` = `AGENDAMENTO`.`COD_AGENDAMENTO`))) where ((`AGENDAMENTO`.`IND_ATIVO` = 1) and (date_format(curdate(),'%Y%m') = date_format((`AGENDAMENTO`.`DAT_INICIO` + interval (`PERIODO`.`NUM_PERIODO` * round((period_diff(date_format(curdate(),'%Y%m'),date_format(`AGENDAMENTO`.`DAT_INICIO`,'%Y%m')) / `PERIODO`.`NUM_PERIODO`),0)) month),'%Y%m'))) order by (`AGENDAMENTO`.`DAT_INICIO` + interval (`PERIODO`.`NUM_PERIODO` * round((period_diff(date_format(curdate(),'%Y%m'),date_format(`AGENDAMENTO`.`DAT_INICIO`,'%Y%m')) / `PERIODO`.`NUM_PERIODO`),0)) month),concat(`CATEGORIA`.`NOM_CATEGORIA`,' (',`AGENDAMENTO`.`NOM_AGENDAMENTO`,')');


# Replace placeholder table for vw_agenda_atual with correct view syntax
# ------------------------------------------------------------

DROP TABLE `vw_agenda_atual`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_agenda_atual`
AS SELECT
   `vw_agendamentos`.`COD_USUARIO` AS `COD_USUARIO`,
   `vw_agendamentos`.`DAT_PREVISTA` AS `DAT_PREVISTA`,
   `vw_agendamentos`.`COD_AGENDAMENTO` AS `COD_AGENDAMENTO`,0 AS `COD_PARCELA`,0 AS `COD_CARTAO_CREDITO`,
   `vw_agendamentos`.`COD_CATEGORIA` AS `COD_CATEGORIA`,
   `vw_agendamentos`.`DES_CATEGORIA` AS `DES_CATEGORIA`,
   `vw_agendamentos`.`VAL_PREVISTO` AS `VAL_PREVISTO`,
   `vw_agendamentos`.`DAT_PAGAMENTO` AS `DAT_PAGAMENTO`,
   `vw_agendamentos`.`VAL_PAGO` AS `VAL_PAGO`
FROM `vw_agendamentos`;


# Replace placeholder table for vw_relatorio with correct view syntax
# ------------------------------------------------------------

DROP TABLE `vw_relatorio`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_relatorio`
AS SELECT
   `LANCAMENTO`.`COD_USUARIO` AS `COD_USUARIO`,
   `LANCAMENTO`.`COD_LANCAMENTO` AS `COD_LANCAMENTO`,
   `LANCAMENTO`.`DAT_REFERENCIA` AS `DAT_REFERENCIA`,
   `LANCAMENTO`.`DAT_LANCAMENTO` AS `DAT_LANCAMENTO`,date_format(`LANCAMENTO`.`DAT_REFERENCIA`,'%Y/%m') AS `ANO_MES`,(case when (`LANCAMENTO`.`COD_CATEGORIA` = 63) then `LANCAMENTO`.`VAL_PREVISTO` else `LANCAMENTO`.`VAL_LANCAMENTO` end) AS `VAL_PREVISTO`,
   `LANCAMENTO`.`VAL_LANCAMENTO` AS `VAL_LANCAMENTO`,
   `LANCAMENTO`.`DES_TAGS` AS `DES_TAGS`,
   `CATEGORIA`.`COD_CATEGORIA` AS `COD_CATEGORIA`,
   `CATEGORIA`.`NOM_CATEGORIA` AS `NOM_CATEGORIA`,
   `GRUPO`.`COD_GRUPO` AS `COD_GRUPO`,
   `GRUPO`.`NOM_GRUPO` AS `NOM_GRUPO`,
   `PARCELA`.`COD_LANCAMENTO` AS `COD_LANCAMENTO_PARCELA`,
   `PARCELA`.`COD_PARCELA` AS `COD_PARCELA`,
   `PARCELA`.`NUM_PARCELA` AS `NUM_PARCELA`,
   `LANCAMENTO_PARCELA`.`DES_TAGS` AS `DES_TAGS_PARCELA`,
   `CATEGORIA_PARCELA`.`COD_CATEGORIA` AS `COD_CATEGORIA_PARCELA`,
   `CATEGORIA_PARCELA`.`NOM_CATEGORIA` AS `NOM_CATEGORIA_PARCELA`,
   `GRUPO_PARCELA`.`COD_GRUPO` AS `COD_GRUPO_PARCELA`,
   `GRUPO_PARCELA`.`NOM_GRUPO` AS `NOM_GRUPO_PARCELA`,
   `AGENDAMENTO`.`COD_AGENDAMENTO` AS `COD_AGENDAMENTO`,
   `AGENDAMENTO`.`NOM_AGENDAMENTO` AS `NOM_AGENDAMENTO`,
   `CARTAO_CREDITO`.`COD_CARTAO_CREDITO` AS `COD_CARTAO_CREDITO`,concat(`CARTAO_CREDITO`.`NOM_BANDEIRA`,' - ',`CARTAO_CREDITO`.`NOM_CARTAO_CREDITO`) AS `NOM_CARTAO_CREDITO`,(case when (`LANCAMENTO`.`COD_AGENDAMENTO` is not null) then 1 when (`LANCAMENTO`.`COD_PARCELA` is not null) then 2 when ((`GRUPO`.`COD_GRUPO` <> 9) and (`LANCAMENTO`.`COD_CATEGORIA` <> 48)) then 3 when (`GRUPO`.`COD_GRUPO` = 9) then 4 when (`LANCAMENTO`.`COD_CATEGORIA` = 48) then 5 else 3 end) AS `COD_TIPO`
FROM ((((((((`tb_lancamento` `LANCAMENTO` join `tb_categoria` `CATEGORIA` on((`CATEGORIA`.`COD_CATEGORIA` = `LANCAMENTO`.`COD_CATEGORIA`))) join `tb_grupo` `GRUPO` on((`GRUPO`.`COD_GRUPO` = `CATEGORIA`.`COD_GRUPO`))) left join `tb_agendamento` `AGENDAMENTO` on((`AGENDAMENTO`.`COD_AGENDAMENTO` = `LANCAMENTO`.`COD_AGENDAMENTO`))) left join `tb_parcela` `PARCELA` on((`PARCELA`.`COD_PARCELA` = `LANCAMENTO`.`COD_PARCELA`))) left join `tb_lancamento` `LANCAMENTO_PARCELA` on((`LANCAMENTO_PARCELA`.`COD_LANCAMENTO` = `PARCELA`.`COD_LANCAMENTO`))) left join `tb_categoria` `CATEGORIA_PARCELA` on((`CATEGORIA_PARCELA`.`COD_CATEGORIA` = `LANCAMENTO_PARCELA`.`COD_CATEGORIA`))) left join `tb_grupo` `GRUPO_PARCELA` on((`GRUPO_PARCELA`.`COD_GRUPO` = `CATEGORIA_PARCELA`.`COD_GRUPO`))) left join `tb_cartao_credito` `CARTAO_CREDITO` on((`CARTAO_CREDITO`.`COD_CARTAO_CREDITO` = `LANCAMENTO`.`COD_CARTAO_CREDITO`))) where ((`LANCAMENTO`.`DAT_REFERENCIA` >= cast(date_format((curdate() + interval -(12) month),'%Y-%m-01') as date)) and (`LANCAMENTO`.`IND_EXCLUIDO` = 0) and (`LANCAMENTO`.`COD_TIPO_PAGAMENTO` = 1)) order by date_format(`LANCAMENTO`.`DAT_REFERENCIA`,'%Y/%m'),(case when (`LANCAMENTO`.`COD_PARCELA` is not null) then `GRUPO_PARCELA`.`NOM_GRUPO` else `GRUPO`.`NOM_GRUPO` end),(case when (`LANCAMENTO`.`COD_PARCELA` is not null) then `CATEGORIA_PARCELA`.`NOM_CATEGORIA` else `CATEGORIA`.`NOM_CATEGORIA` end),`LANCAMENTO`.`DAT_REFERENCIA`;


# Replace placeholder table for vw_faturas with correct view syntax
# ------------------------------------------------------------

DROP TABLE `vw_faturas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_faturas`
AS SELECT
   `LANCAMENTO`.`COD_USUARIO` AS `COD_USUARIO`,
   `CARTAO_CREDITO`.`COD_CARTAO_CREDITO` AS `COD_CARTAO_CREDITO`,
   `CARTAO_CREDITO`.`NOM_BANDEIRA` AS `NOM_BANDEIRA`,
   `CARTAO_CREDITO`.`NOM_CARTAO_CREDITO` AS `NOM_CARTAO_CREDITO`,
   `LANCAMENTO`.`DAT_FATURA` AS `DAT_FATURA`,
   `LANCAMENTO`.`DAT_REFERENCIA` AS `DAT_REFERENCIA`,
   `LANCAMENTO`.`VAL_PREVISTO` AS `VAL_PREVISTO`,
   `LANCAMENTO`.`VAL_LANCAMENTO` AS `VAL_LANCAMENTO`,count(`PARCELA`.`COD_PARCELA`) AS `QTD_PARCELAS`,sum(`PARCELA`.`VAL_PARCELA`) AS `VAL_PARCELAS`
FROM ((((`tb_lancamento` `LANCAMENTO` join `tb_categoria` `CATEGORIA` on((`CATEGORIA`.`COD_CATEGORIA` = `LANCAMENTO`.`COD_CATEGORIA`))) join `tb_cartao_credito` `CARTAO_CREDITO` on((`CARTAO_CREDITO`.`COD_CARTAO_CREDITO` = `LANCAMENTO`.`COD_CARTAO_CREDITO`))) join `rl_lancamento_parcela` `RL` on((`RL`.`COD_LANCAMENTO` = `LANCAMENTO`.`COD_LANCAMENTO`))) join `tb_parcela` `PARCELA` on((`PARCELA`.`COD_PARCELA` = `RL`.`COD_PARCELA`))) where (`LANCAMENTO`.`COD_CATEGORIA` = 48) group by `LANCAMENTO`.`COD_USUARIO`,`CARTAO_CREDITO`.`COD_CARTAO_CREDITO`,`CARTAO_CREDITO`.`NOM_BANDEIRA`,`CARTAO_CREDITO`.`NOM_CARTAO_CREDITO`,`LANCAMENTO`.`DAT_FATURA`,`LANCAMENTO`.`DAT_REFERENCIA`,`LANCAMENTO`.`VAL_PREVISTO`,`LANCAMENTO`.`VAL_LANCAMENTO`;


# Replace placeholder table for vw_despesas_receitas with correct view syntax
# ------------------------------------------------------------

DROP TABLE `vw_despesas_receitas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_despesas_receitas`
AS SELECT
   `LANCAMENTO`.`COD_USUARIO` AS `COD_USUARIO`,cast(date_format(`LANCAMENTO`.`DAT_REFERENCIA`,'%Y-%m-01') as date) AS `DAT_COMPETENCIA`,round(sum(`LANCAMENTO`.`VAL_PREVISTO`),2) AS `VAL_DESPESA_PREVISTA`,round(sum(`LANCAMENTO`.`VAL_LANCAMENTO`),2) AS `VAL_DESPESA_PAGA`,0 AS `VAL_RECEITA_PREVISTA`,0 AS `VAL_RECEITA_PAGA`
FROM (`tb_lancamento` `LANCAMENTO` join `tb_categoria` `CATEGORIA` on((`CATEGORIA`.`COD_CATEGORIA` = `LANCAMENTO`.`COD_CATEGORIA`))) where ((`CATEGORIA`.`COD_GRUPO` <> 9) and (`LANCAMENTO`.`DAT_REFERENCIA` between cast(date_format((curdate() + interval -(12) month),'%Y-%m-01') as date) and cast(date_format(curdate(),'%Y-%m-01') as date))) group by `LANCAMENTO`.`COD_USUARIO`,cast(date_format(`LANCAMENTO`.`DAT_REFERENCIA`,'%Y-%m-01') as date) union all select `LANCAMENTO`.`COD_USUARIO` AS `COD_USUARIO`,cast(date_format(`LANCAMENTO`.`DAT_REFERENCIA`,'%Y-%m-01') as date) AS `DAT_COMPETENCIA`,0 AS `VAL_DESPESA_PREVISTA`,0 AS `VAL_DESPESA_PAGA`,round(sum(`LANCAMENTO`.`VAL_PREVISTO`),2) AS `VAL_RECEITA_PREVISTA`,round(sum(`LANCAMENTO`.`VAL_LANCAMENTO`),2) AS `VAL_RECEITA_PAGA` from (`tb_lancamento` `LANCAMENTO` join `tb_categoria` `CATEGORIA` on((`CATEGORIA`.`COD_CATEGORIA` = `LANCAMENTO`.`COD_CATEGORIA`))) where ((`CATEGORIA`.`COD_GRUPO` = 9) and (`LANCAMENTO`.`DAT_REFERENCIA` between cast(date_format((curdate() + interval -(12) month),'%Y-%m-01') as date) and cast(date_format(curdate(),'%Y-%m-01') as date))) group by `LANCAMENTO`.`COD_USUARIO`,cast(date_format(`LANCAMENTO`.`DAT_REFERENCIA`,'%Y-%m-01') as date);


# Replace placeholder table for vw_media_agendamentos with correct view syntax
# ------------------------------------------------------------

DROP TABLE `vw_media_agendamentos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_media_agendamentos`
AS SELECT
   `tb_lancamento`.`COD_AGENDAMENTO` AS `COD_AGENDAMENTO`,count(0) AS `NUM_QTD`,sum(`tb_lancamento`.`VAL_LANCAMENTO`) AS `VAL_TOTAL`,round((sum(`tb_lancamento`.`VAL_LANCAMENTO`) / count(0)),2) AS `VAL_MEDIA`
FROM `tb_lancamento` where ((`tb_lancamento`.`COD_AGENDAMENTO` is not null) and (`tb_lancamento`.`DAT_REFERENCIA` between cast(date_format((curdate() + interval -(3) month),'%Y-%m-01') as date) and cast(date_format(curdate(),'%Y-%m-01') as date))) group by `tb_lancamento`.`COD_AGENDAMENTO`;


# Replace placeholder table for vw_resumo_mes with correct view syntax
# ------------------------------------------------------------

DROP TABLE `vw_resumo_mes`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_resumo_mes`
AS SELECT
   `vw_lancamentos`.`COD_USUARIO` AS `COD_USUARIO`,
   `vw_lancamentos`.`DES_LANCAMENTOS` AS `DES_LANCAMENTOS`,
   `vw_lancamentos`.`COD_TIPO` AS `COD_TIPO`,(case when isnull(`vw_lancamentos`.`VAL_PREVISTO`) then 0 else `vw_lancamentos`.`VAL_PREVISTO` end) AS `VAL_PREVISTO`,(case when isnull(`vw_lancamentos`.`VAL_PAGO`) then 0 else `vw_lancamentos`.`VAL_PAGO` end) AS `VAL_PAGO`
FROM `vw_lancamentos`;


# Replace placeholder table for vw_ultimas_atividades with correct view syntax
# ------------------------------------------------------------

DROP TABLE `vw_ultimas_atividades`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_ultimas_atividades`
AS SELECT
   `LANCAMENTO`.`COD_USUARIO` AS `COD_USUARIO`,date_format(`LANCAMENTO`.`DAT_REFERENCIA`,'%Y/%m') AS `ANO_MES`,
   `LANCAMENTO`.`DAT_REFERENCIA` AS `DAT_REFERENCIA`,
   `LANCAMENTO`.`DAT_LANCAMENTO` AS `DAT_LANCAMENTO`,timestampdiff(DAY,`LANCAMENTO`.`DAT_LANCAMENTO`,now()) AS `NUM_DIAS`,timestampdiff(HOUR,`LANCAMENTO`.`DAT_LANCAMENTO`,now()) AS `NUM_HORAS`,timestampdiff(MINUTE,`LANCAMENTO`.`DAT_LANCAMENTO`,now()) AS `NUM_MINUTOS`,(case when ((`LANCAMENTO`.`COD_CARTAO_CREDITO` is not null) and (`LANCAMENTO`.`COD_CATEGORIA` <> 48)) then `LANCAMENTO`.`VAL_PREVISTO` else `LANCAMENTO`.`VAL_LANCAMENTO` end) AS `VAL_LANCAMENTO`,(case when (`LANCAMENTO`.`COD_AGENDAMENTO` is not null) then concat(`CATEGORIA`.`NOM_CATEGORIA`,' (',`AGENDAMENTO`.`NOM_AGENDAMENTO`,')') when (`LANCAMENTO`.`COD_PARCELA` is not null) then concat('PARCELA N ',`PARCELA`.`NUM_PARCELA`,' (',`CATEGORIA_PARCELA`.`NOM_CATEGORIA`,')') when ((`LANCAMENTO`.`COD_CARTAO_CREDITO` is not null) and (`LANCAMENTO`.`COD_CATEGORIA` = 48)) then concat(`CATEGORIA`.`NOM_CATEGORIA`,'(',`CARTAO_CREDITO`.`NOM_BANDEIRA`,' - ',`CARTAO_CREDITO`.`NOM_CARTAO_CREDITO`,')') else `CATEGORIA`.`NOM_CATEGORIA` end) AS `DES_CATEGORIA`
FROM ((((((`tb_lancamento` `LANCAMENTO` join `tb_categoria` `CATEGORIA` on((`CATEGORIA`.`COD_CATEGORIA` = `LANCAMENTO`.`COD_CATEGORIA`))) left join `tb_agendamento` `AGENDAMENTO` on((`AGENDAMENTO`.`COD_AGENDAMENTO` = `LANCAMENTO`.`COD_AGENDAMENTO`))) left join `tb_cartao_credito` `CARTAO_CREDITO` on((`CARTAO_CREDITO`.`COD_CARTAO_CREDITO` = `LANCAMENTO`.`COD_CARTAO_CREDITO`))) left join `tb_parcela` `PARCELA` on((`PARCELA`.`COD_PARCELA` = `LANCAMENTO`.`COD_PARCELA`))) left join `tb_lancamento` `LANCAMENTO_PARCELA` on((`LANCAMENTO_PARCELA`.`COD_LANCAMENTO` = `PARCELA`.`COD_LANCAMENTO`))) left join `tb_categoria` `CATEGORIA_PARCELA` on((`CATEGORIA_PARCELA`.`COD_CATEGORIA` = `LANCAMENTO_PARCELA`.`COD_CATEGORIA`))) order by date_format(`LANCAMENTO`.`DAT_REFERENCIA`,'%Y/%m'),`LANCAMENTO`.`DAT_LANCAMENTO`,(case when (`LANCAMENTO`.`COD_AGENDAMENTO` is not null) then concat(`CATEGORIA`.`NOM_CATEGORIA`,' (',`AGENDAMENTO`.`NOM_AGENDAMENTO`,')') when (`LANCAMENTO`.`COD_PARCELA` is not null) then concat('PARCELA N ',`PARCELA`.`NUM_PARCELA`,' (',`CATEGORIA_PARCELA`.`NOM_CATEGORIA`,')') when ((`LANCAMENTO`.`COD_CARTAO_CREDITO` is not null) and (`LANCAMENTO`.`COD_CATEGORIA` = 48)) then concat(`CATEGORIA`.`NOM_CATEGORIA`,'(',`CARTAO_CREDITO`.`NOM_BANDEIRA`,' - ',`CARTAO_CREDITO`.`NOM_CARTAO_CREDITO`,')') else `CATEGORIA`.`NOM_CATEGORIA` end);

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
