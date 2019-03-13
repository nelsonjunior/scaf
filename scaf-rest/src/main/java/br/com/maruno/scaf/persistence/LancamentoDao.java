package br.com.maruno.scaf.persistence;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import br.com.maruno.scaf.domain.Domain;
import br.com.maruno.scaf.domain.Lancamento;
   
/**
 * @Aplicativo 
 * @Modulo scaf-rest
 * @Autor <a href="mailto:jackmaruno@gmail.com">Willian.Maruno</a>
 * @Data Jan 15, 2019 5:51:34 PM
 * @Pacote br.com.maruno.scaf.persistence
 * @Nome LancamentoDao.java
 * @NomeCompleto br.com.maruno.scaf.persistence.LancamentoDao.java
 */
public interface LancamentoDao extends JpaRepository<Lancamento, Integer> { 

	List<Lancamento> findByCodUsuario(Integer codUsuario);
	
	Lancamento findByCodigoAndCodUsuario(Integer codigo, Integer codUsuario);

	@Query(" SELECT l FROM Lancamento l "
		 + " JOIN l.categoria c"
		 + " JOIN c.grupo g"
		 + " WHERE l.codUsuario = :codUsuario"
		 + " AND (:codLancamento IS NULL or l.codigo = :codLancamento) "
		 + " AND (:codGrupo      IS NULL or g.codigo = :codGrupo) "
		 + " AND (:codCategoria  IS NULL or c.codigo = :codCategoria) "
		 + " AND ((:dataInicio   IS NULL or :dataFim is null) or l.dataReferencia between :dataInicio and :dataFim)"
		 + " AND (:descricao     IS NULL or UPPER(l.descricao) like %:descricao%) "
		 + " ORDER BY l.dataReferencia, c.nome ")
	List<Lancamento> findByParameters(@Param("codLancamento") Integer codLancamento
			                        , @Param("codGrupo")      Integer codGrupo
			                        , @Param("codCategoria")  Integer codCategoria
			                        , @Param("dataInicio")    Date    dataInicio
			                        , @Param("dataFim")       Date    dataFim
			                        , @Param("descricao")     String  descricao
			                        , @Param("codUsuario")    Integer codUsuario);

	@Query(value = " SELECT * FROM "+Domain.SCHEMA+".TB_LANCAMENTO WHERE COD_LANCAMENTO = :codLancamento", nativeQuery = true )
	Lancamento findById(@Param("codLancamento") Integer codLancamento);
	
	@Query(" SELECT l FROM Lancamento l "
		 + " JOIN l.parcela p"
		 + " WHERE p.codigo = :codParcela" )
	Lancamento findByParcela(@Param("codParcela") Integer codParcela);
	
	
	@Query(value = " SELECT DISTINCT L.* FROM "+Domain.SCHEMA+".RL_LANCAMENTO_PARCELA RL "
				 + " INNER JOIN "+Domain.SCHEMA+".TB_LANCAMENTO L ON L.COD_LANCAMENTO = RL.COD_LANCAMENTO"
				 + " WHERE RL.COD_PARCELA = :codParcela", nativeQuery = true )
	Lancamento findByParcelaFatura(@Param("codParcela") Integer codParcela);
	

	@Modifying
	@Transactional
	@Query(value = " UPDATE "+Domain.SCHEMA+".TB_LANCAMENTO "
				 + " SET VAL_LANCAMENTO = VAL_LANCAMENTO + :valor"
				 + " WHERE COD_LANCAMENTO = :codLancamento", nativeQuery = true )
	int updateValorRealizado(@Param("codLancamento") Integer codLancamento, @Param("valor") BigDecimal valor);
	
	
	@Modifying
	@Transactional
	@Query(value = " UPDATE "+Domain.SCHEMA+".TB_LANCAMENTO"
			     + " SET IND_EXCLUIDO   = 1"
			     + "   , DAT_ALTERACAO  = NOW()"
			     + " WHERE COD_USUARIO  = :codUsuario"
			     + " AND COD_LANCAMENTO = :codigo", nativeQuery = true)
	int remove(@Param("codUsuario") Integer codUsuario, @Param("codigo") Integer codigo);
	
	

    @Query(nativeQuery = true, 
		    value = " SELECT * " + 
		    		" FROM "+Domain.SCHEMA+".TB_LANCAMENTO " + 
		    		" WHERE COD_CATEGORIA    = 48" +  
		    		" AND IND_EXCLUIDO       = 0" +
		    		" AND COD_USUARIO        = :codUsuario "+
		    		" AND COD_CARTAO_CREDITO = :codCartaoCredito" + 
		    		" AND (:anoMes IS NULL or DATE_FORMAT(DAT_FATURA,'%Y%m') = :anoMes)")	
    List<Lancamento> findLancamentosFaturas(@Param("codUsuario") Integer codUsuario, @Param("codCartaoCredito") Integer codCartaoCredito, @Param("anoMes") String anoMes);
 
    
    @Query(nativeQuery = true, 
    		value = " SELECT DAT_FATURA, DAT_REFERENCIA, VAL_LANCAMENTO " + 
    				" FROM "+Domain.SCHEMA+".VW_FATURAS_DATAS " + 
    				" WHERE COD_USUARIO        = :codUsuario "+
    		        " AND   COD_CARTAO_CREDITO = :codCartaoCredito")	
    List<Object[]> findDatasFaturas(@Param("codUsuario") Integer codUsuario, @Param("codCartaoCredito") Integer codCartaoCredito); 
    
    
}
