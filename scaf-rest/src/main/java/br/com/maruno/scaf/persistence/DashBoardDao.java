package br.com.maruno.scaf.persistence;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import br.com.maruno.scaf.domain.Domain;
import br.com.maruno.scaf.domain.Lancamento;
   
/**
 * @Aplicativo 
 * @Modulo scaf-rest
 * @Autor <a href="mailto:jackmaruno@gmail.com">Willian.Maruno</a>
 * @Pacote br.com.maruno.scaf.persistence
 * @Nome DashBoardDao.java
 * @NomeCompleto br.com.maruno.scaf.persistence.DashBoardDao.java
 */
public interface DashBoardDao extends JpaRepository<Lancamento, Integer> { 
 
    @Query(nativeQuery = true, 
    value = " select DES_CATEGORIA, "+
    		"        VAL_LANCAMENTO, "+
    		"        DAT_LANCAMENTO, "+
    		"        NUM_DIAS, "+
    		"        NUM_HORAS, "+
    		"        NUM_MINUTOS "+
			" from VW_ULTIMAS_ATIVIDADES "+ 
			" where ANO_MES = :competencia "+ 
		    " and COD_USUARIO = :codUsuario ")	
    List<Object[]> findUltimasAtividades(@Param("codUsuario") Integer codUsuario, @Param("competencia") String competencia);
    
	@Query(value = " " + 
			"  SELECT PARCELA.DAT_PARCELA AS DAT_PREVISTA " + 
			"      , 0 AS COD_AGENDAMENTO" + 
			"      , PARCELA.COD_PARCELA " + 
			"      , 0 AS COD_CARTAO_CREDITO" + 
			"      , '' AS NOME" + 
			"      , 46 AS COD_CATEGORIA " + 
			"      , concat('Parcela N ', PARCELA.NUM_PARCELA, ' (', CATEGORIA.NOM_CATEGORIA, ')') AS DES_CATEGORIA " + 
			"      , PARCELA.VAL_PARCELA AS VAL_PREVISTO " + 
			"	   , LANCAMENTO_PAGAMENTO.DAT_REFERENCIA AS DAT_PAGAMENTO " + 
			"      , LANCAMENTO_PAGAMENTO.VAL_LANCAMENTO AS VAL_PAGO " + 
			"      , timestampdiff(DAY,now(),PARCELA.DAT_PARCELA) AS DIAS " + 
			"\n" + 
			" FROM "+Domain.SCHEMA+".TB_PARCELA PARCELA\n" + 
			"\n" + 
			"	INNER JOIN "+Domain.SCHEMA+".TB_LANCAMENTO LANCAMENTO ON LANCAMENTO.COD_LANCAMENTO = PARCELA.COD_LANCAMENTO\n" + 
			"\n" + 
			"	INNER JOIN "+Domain.SCHEMA+".TB_CATEGORIA CATEGORIA ON CATEGORIA.COD_CATEGORIA = LANCAMENTO.COD_CATEGORIA\n" + 
			"\n" + 
			"	INNER JOIN "+Domain.SCHEMA+".TB_LANCAMENTO LANCAMENTO_PAGAMENTO ON LANCAMENTO_PAGAMENTO.COD_PARCELA = PARCELA.COD_PARCELA\n" + 
			"\n" + 
			"\n WHERE LANCAMENTO.COD_USUARIO = :codUsuario \n" + 
			"\n AND isnull(LANCAMENTO.COD_CARTAO_CREDITO)\n" + 
			"\n AND ( date_format(curdate(),'%Y%m') = date_format(PARCELA.DAT_PARCELA,'%Y%m')\n" + 
			"\n		or ((PARCELA.DAT_PARCELA < concat(date_format(curdate(),'%Y-%m'),'-01')) and isnull(LANCAMENTO_PAGAMENTO.DAT_REFERENCIA))\n" + 
			"\n    )", nativeQuery = true)	
	List<Object[]> findParcelas(@Param("codUsuario") Integer codUsuario);
	
	@Query(value = "" + 
	        " select FATURAS.DAT_FATURA \n" + 
			"      , NULL AS COD_AGENDAMENTO\n" + 
			"      , NULL AS COD_PARCELA\n" + 
			"      , FATURAS.COD_CARTAO_CREDITO \n" + 
			"      , concat(FATURAS.NOM_BANDEIRA,' - ', FATURAS.NOM_CARTAO_CREDITO) AS NOME\n" + 
			"      , CATEGORIA.COD_CATEGORIA \n" + 
			"      , concat(CATEGORIA.NOM_CATEGORIA, '(', FATURAS.NOM_BANDEIRA, ' - ', FATURAS.NOM_CARTAO_CREDITO, ')') AS DES_CATEGORIA\n" + 
			"      , FATURAS.VAL_PARCELAS_PENDENTES AS VAL_PREVISTO\n" + 
			"      , FATURAS.DAT_REFERENCIA AS DAT_PAGAMENTO\n" + 
			"      , FATURAS.VAL_LANCAMENTO AS VAL_PAGO\n" + 
			"      , timestampdiff(DAY,now(),FATURAS.DAT_FATURA) AS DIAS \n" + 
			"\n" + 
			" FROM VW_FATURAS_PREVISTAS_REALIZADAS FATURAS\n" + 
			"\n" + 
			"	INNER JOIN TB_CATEGORIA CATEGORIA ON CATEGORIA.COD_CATEGORIA = 48\n" + 
			"\n" + 
			" WHERE FATURAS.COD_USUARIO = :codUsuario  \n" + 
			" AND isnull(FATURAS.DAT_REFERENCIA) \n" + 
			" AND (\n" + 
			"  date_format(curdate(),'%Y%m') = date_format(FATURAS.DAT_FATURA,'%Y%m')\n" + 
			"  or (\n" + 
			"     FATURAS.DAT_FATURA < concat(date_format(curdate(),'%Y-%m'),'-01') and isnull(FATURAS.DAT_REFERENCIA)\n" + 
			"  )\n" + 
			") \n" + 
			" AND FATURAS.QTD_PARCELAS_PENDENTES > 0\n" + 
			"\n" + 
			"\n" + 
			" order by DAT_PREVISTA,DES_CATEGORIA", nativeQuery = true)	
	List<Object[]> findFaturas(@Param("codUsuario") Integer codUsuario);
	
	
    @Query(nativeQuery = true, 
    value = " select DAT_PREVISTA, "+
    		"        COD_AGENDAMENTO, "+
    		"        COD_PARCELA, "+
    		"        COD_CARTAO_CREDITO, "+
    		"        COD_CATEGORIA, "+
    		"        DES_CATEGORIA, "+
    		"        VAL_PREVISTO, "+
    		"        DAT_PAGAMENTO, "+
    		"        VAL_PAGO,  "+
    		"        DIAS  "+
			" from VW_PROXIMAS_ATIVIDADES "+
			" where COD_USUARIO = :codUsuario ")
    List<Object[]> findProximasAtividades(@Param("codUsuario") Integer codUsuario);
    

    @Query(nativeQuery = true, 
    value = " select DES_LANCAMENTOS, "+
    		"        COD_TIPO, "+
    		"        VAL_PREVISTO, "+
    		"        VAL_PAGO "+
			" from VW_RESUMO_MES "+
			" where COD_USUARIO = :codUsuario "+ 
			" order by DES_LANCAMENTOS")
    List<Object[]> findResumoMes(@Param("codUsuario") Integer codUsuario);
    

    @Query(nativeQuery = true, 
    value = " select DAT_COMPETENCIA, "+
    		"        sum(VAL_DESPESA_PAGA) as VAL_DESPESA_PAGA, "+
    		"        sum(VAL_RECEITA_PAGA) as VAL_RECEITA_PAGA "+
    		" from VW_DESPESAS_RECEITAS "+
    		" where COD_USUARIO = :codUsuario "+ 
    		" group by DAT_COMPETENCIA"+ 
    		" order by DAT_COMPETENCIA")
    List<Object[]> findDespesasReceitas(@Param("codUsuario") Integer codUsuario);
    

    @Query(nativeQuery = true, 
    value =" SELECT DAT_PREVISTA,"+
			"       COD_AGENDAMENTO, "+
			"       COD_PARCELA,"+
			"       COD_CARTAO_CREDITO,"+
			"       COD_CATEGORIA,"+
			"       DES_CATEGORIA,"+
			"       VAL_PREVISTO,"+
			"       DAT_PAGAMENTO,"+
			"       VAL_PAGO"+
			" FROM VW_AGENDA_ATUAL"+
    		" where COD_USUARIO = :codUsuario"+ 
    		" order by DAT_PREVISTA, DES_CATEGORIA")
    List<Object[]> findAgendaAtual(@Param("codUsuario") Integer codUsuario);
    

    @Query(nativeQuery = true, 
    value = " SELECT COD_LANCAMENTO,  "+
			"       COD_TIPO, "+
			"       COD_LANCAMENTO_PARCELA, "+
			"       DES_CATEGORIA, "+
			"       NUM_PARCELA, "+
			"       NOM_AGENDAMENTO, "+
			"       DAT_LANCAMENTO, "+
			"       DAT_REFERENCIA, "+
			"       VAL_PREVISTO,  "+ 
			"       VAL_PAGO  "+  
			" FROM VW_RELACAO_LANCAMENTO  "+
    		" where COD_USUARIO = :codUsuario "+ 
    		" and ANO_MES = :competencia"+ 
    		" and COD_TIPO = :codTipo")
    List<Object[]> findRelacaoLancamentos(@Param("codUsuario") Integer codUsuario, @Param("competencia") String competencia, @Param("codTipo") Integer codTipo);
}
