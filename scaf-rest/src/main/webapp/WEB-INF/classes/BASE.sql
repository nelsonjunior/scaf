
/*--------------------------------------------------------------
| TB_CONFIGURACAO
--------------------------------------------------------------*/
CREATE TABLE TB_CONFIGURACAO (
  COD_CONFIGURACAO      INTEGER      NOT NULL AUTO_INCREMENT,
  NOM_CONFIGURACAO      VARCHAR(100) NOT NULL,
  DES_CONFIGURACAO      VARCHAR(400)     NULL, 
  PRIMARY KEY (COD_CONFIGURACAO) 
) ENGINE=InnoDB DEFAULT CHARSET=latin1; 

/*--------------------------------------------------------------
| TB_PONTO
--------------------------------------------------------------*/
CREATE TABLE TB_PONTO (
  COD_PONTO    INTEGER   NOT NULL AUTO_INCREMENT,
  COD_USUARIO  INTEGER   NOT NULL, 
  DAT_CADASTRO TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  DAT_REGISTRO TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,  
  PRIMARY KEY (COD_PONTO) 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*--------------------------------------------------------------
| VW_PONTO
--------------------------------------------------------------*/
CREATE OR REPLACE VIEW VW_PONTO AS
SELECT COD_PONTO
      ,COD_USUARIO
      ,DAT_REGISTRO
      ,DATE_FORMAT(DAT_REGISTRO, '%d/%m/%Y') AS DAT_PONTO
      ,DATE_FORMAT(DAT_REGISTRO, '%H:%i')    AS HOR_PONTO
      ,DATE_FORMAT(DAT_REGISTRO, '%Y%m')     AS MES_PONTO
FROM TB_PONTO;       

/*--------------------------------------------------------------
| VW_PONTO_DATA_HORA
--------------------------------------------------------------*/
CREATE OR REPLACE VIEW VW_PONTO_DATA_HORA AS
SELECT CONCAT(COD_USUARIO, DATE_FORMAT(DAT_REGISTRO, '%Y%m%d')) AS ID, COD_USUARIO, MES_PONTO, DAT_PONTO, GROUP_CONCAT(HOR_PONTO ORDER BY HOR_PONTO SEPARATOR ';') AS HOR_PONTO 
FROM VW_PONTO 

GROUP BY CONCAT(COD_USUARIO, DATE_FORMAT(DAT_REGISTRO, '%Y%m%d')) , COD_USUARIO, MES_PONTO, DAT_PONTO
ORDER BY DAT_PONTO
;

/*--------------------------------------------------------------
| CARGA
--------------------------------------------------------------*/      
INSERT INTO TB_PONTO (COD_USUARIO, DAT_REGISTRO) VALUES(1, '2018-08-25 08:30'), (1, '2018-08-25 12:15'), (1, '2018-08-25 13:15'), (1, '2018-08-25 17:30'); 
INSERT INTO TB_PONTO (COD_USUARIO, DAT_REGISTRO) VALUES(1, '2018-08-26 08:30'), (1, '2018-08-26 12:15'), (1, '2018-08-26 13:15'), (1, '2018-08-26 17:30'); 
INSERT INTO TB_PONTO (COD_USUARIO, DAT_REGISTRO) VALUES(1, '2018-08-27 08:30'), (1, '2018-08-27 12:15'), (1, '2018-08-27 13:15'), (1, '2018-08-27 17:30'); 
INSERT INTO TB_PONTO (COD_USUARIO, DAT_REGISTRO) VALUES(1, '2018-08-28 08:30'), (1, '2018-08-28 12:15'), (1, '2018-08-28 13:15'), (1, '2018-08-28 17:30');
      


INSERT INTO TB_CONFIGURACAO(NOM_CONFIGURACAO, DES_CONFIGURACAO) VALUES('url.autenticacao', 'http://localhost:8080/quaemo-autenticacao/api');
INSERT INTO TB_CONFIGURACAO(NOM_CONFIGURACAO, DES_CONFIGURACAO) VALUES('url.sistema', 'http://localhost:8080/quaemo-corporativo/api/corporativo/sistemas');
INSERT INTO TB_CONFIGURACAO(NOM_CONFIGURACAO, DES_CONFIGURACAO) VALUES('url.sistema.aplicacao.cliente', 'http://localhost:8080/quaemo-corporativo/api/corporativo/sistemas/{codSistema}/aplicacao-cliente');
INSERT INTO TB_CONFIGURACAO(NOM_CONFIGURACAO, DES_CONFIGURACAO) VALUES('url.sistema.perfil', 'http://localhost:8080/quaemo-corporativo/api/corporativo/sistemas/{codSistema}/perfis');
INSERT INTO TB_CONFIGURACAO(NOM_CONFIGURACAO, DES_CONFIGURACAO) VALUES('url.sistema.recurso', 'http://localhost:8080/quaemo-corporativo/api/corporativo/sistemas/{codSistema}/recursos');
INSERT INTO TB_CONFIGURACAO(NOM_CONFIGURACAO, DES_CONFIGURACAO) VALUES('url.sistema.usuario', 'http://localhost:8080/quaemo-corporativo/api/corporativo/sistemas/{codSistema}/usuarios');
INSERT INTO TB_CONFIGURACAO(NOM_CONFIGURACAO, DES_CONFIGURACAO) VALUES('url.sistema.usuario.menu', 'http://localhost:8080/quaemo-corporativo/api/corporativo/sistemas/{codSistema}/usuarios/menus');
INSERT INTO TB_CONFIGURACAO(NOM_CONFIGURACAO, DES_CONFIGURACAO) VALUES('url.sistema.usuario.status', 'http://localhost:8080/quaemo-corporativo/api/corporativo/sistemas/{codSistema}/usuarios/{codUsuario}/status');
INSERT INTO TB_CONFIGURACAO(NOM_CONFIGURACAO, DES_CONFIGURACAO) VALUES('url.usuario', 'http://localhost:8080/quaemo-corporativo/api/corporativo/usuarios/');
INSERT INTO TB_CONFIGURACAO(NOM_CONFIGURACAO, DES_CONFIGURACAO) VALUES('url.usuario.foto', 'http://localhost:8080/quaemo-corporativo/api/corporativo/usuarios/{codUsuario}/fotos');
INSERT INTO TB_CONFIGURACAO(NOM_CONFIGURACAO, DES_CONFIGURACAO) VALUES('url.usuario.login', 'http://localhost:8080/quaemo-corporativo/api/corporativo/usuarios/{login}');
INSERT INTO TB_CONFIGURACAO(NOM_CONFIGURACAO, DES_CONFIGURACAO) VALUES('url.usuario.senha', 'http://localhost:8080/quaemo-corporativo/api/corporativo/usuarios/{login}/senha');
INSERT INTO TB_CONFIGURACAO(NOM_CONFIGURACAO, DES_CONFIGURACAO) VALUES('pah.arquivos', 'C:\mnt\quaemo\ponto');