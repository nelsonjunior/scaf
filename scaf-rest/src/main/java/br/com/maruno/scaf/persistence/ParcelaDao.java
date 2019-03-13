package br.com.maruno.scaf.persistence;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import br.com.maruno.scaf.domain.Domain;
import br.com.maruno.scaf.domain.Parcela;
    
public interface ParcelaDao extends JpaRepository<Parcela, Integer> { 

	List<Parcela> findByCodLancamento(Integer codLancamento);


	@Query(value = " SELECT p.* FROM "+Domain.SCHEMA+".TB_PARCELA p"
		         + " INNER JOIN "+Domain.SCHEMA+".TB_LANCAMENTO l ON l.COD_LANCAMENTO = p.COD_LANCAMENTO"
		         + " WHERE l.IND_EXCLUIDO = 0"
		         + " AND l.COD_USUARIO = :codUsuario"
				 + " AND p.COD_PARCELA = :codParcela"  , nativeQuery = true)	
	Parcela findParcelaById(@Param("codUsuario") Integer codUsuario, @Param("codParcela") Integer codParcela);

	@Query(value = " SELECT p.* FROM "+Domain.SCHEMA+".TB_PARCELA p"
		         + " INNER JOIN "+Domain.SCHEMA+".TB_LANCAMENTO l ON l.COD_LANCAMENTO = p.COD_LANCAMENTO"
		         + " LEFT JOIN "+Domain.SCHEMA+".TB_LANCAMENTO l2 ON l2.COD_PARCELA = p.COD_PARCELA"
		         + " WHERE l2.COD_LANCAMENTO IS NULL "
		         + " AND l.IND_EXCLUIDO = 0"
		         + " AND l.COD_USUARIO = :codUsuario"
				 + " AND (l.COD_TIPO_PAGAMENTO = 2 Or l.COD_CATEGORIA = 63)"
				 + " AND (:anoMes IS NULL or DATE_FORMAT(p.DAT_PARCELA,'%Y%m') = :anoMes) "
				 + " ORDER BY p.DAT_PARCELA, l.DAT_LANCAMENTO", nativeQuery = true)	
	List<Parcela> findParcelasPendentes(@Param("codUsuario") Integer codUsuario, @Param("anoMes") String anoMes);
	
	@Query(value = " SELECT p.* FROM "+Domain.SCHEMA+".TB_PARCELA p"
			+ " INNER JOIN "+Domain.SCHEMA+".TB_LANCAMENTO l ON l.COD_LANCAMENTO = p.COD_LANCAMENTO"
			+ " LEFT JOIN "+Domain.SCHEMA+".TB_LANCAMENTO l2 ON l2.COD_PARCELA = p.COD_PARCELA"
			+ " WHERE l2.COD_LANCAMENTO IS NOT NULL "
	        + " AND l.IND_EXCLUIDO = 0"
			+ " AND l.COD_USUARIO = :codUsuario"
			+ " AND (l.COD_TIPO_PAGAMENTO = 2 Or l.COD_CATEGORIA = 63)"
			+ " AND (:anoMes IS NULL or DATE_FORMAT(p.DAT_PARCELA,'%Y%m') = :anoMes) "
			+ " ORDER BY p.DAT_PARCELA, l.DAT_LANCAMENTO", nativeQuery = true)	
	List<Parcela> findParcelasPagas(@Param("codUsuario") Integer codUsuario, @Param("anoMes") String anoMes);
	
	@Query(value = " SELECT DISTINCT DATE_FORMAT(p.DAT_PARCELA,'%Y%m') AS ANO_MES, DATE_FORMAT(p.DAT_PARCELA,'%m/%Y') AS DATA "
			+ " FROM "+Domain.SCHEMA+".TB_PARCELA p"
			+ " INNER JOIN "+Domain.SCHEMA+".TB_LANCAMENTO l ON l.COD_LANCAMENTO = p.COD_LANCAMENTO"
			+ " LEFT JOIN "+Domain.SCHEMA+".TB_LANCAMENTO l2 ON l2.COD_PARCELA = p.COD_PARCELA"
			+ " WHERE l2.COD_LANCAMENTO IS NULL "
	        + " AND l.IND_EXCLUIDO = 0"
			+ " AND l.COD_USUARIO = :codUsuario"
			+ " AND (l.COD_TIPO_PAGAMENTO = 2 Or l.COD_CATEGORIA = 63)"
			+ " ORDER BY 1" , nativeQuery = true)	
	List<Object[]> findDatasParcelasPendentes(@Param("codUsuario") Integer codUsuario);
	
	@Query(value = " SELECT p.* FROM "+Domain.SCHEMA+".TB_PARCELA p"
			+ " INNER JOIN "+Domain.SCHEMA+".TB_LANCAMENTO l ON l.COD_LANCAMENTO = p.COD_LANCAMENTO"
	        + " WHERE l.IND_EXCLUIDO                      = 0"
	        + " AND l.COD_USUARIO                         = :codUsuario"
			+ " AND l.COD_CARTAO_CREDITO                  = :codCartaoCredito"
			+ " AND DATE_FORMAT(p.DAT_PARCELA,'%d/%m/%Y') = :data"
			+ " ORDER BY p.DAT_PARCELA, l.DAT_LANCAMENTO", nativeQuery = true)	
	List<Parcela> findByParameters(@Param("codUsuario") Integer codUsuario, @Param("codCartaoCredito") Integer codCartaoCredito, @Param("data") String data);
	
	@Query(value = " SELECT p.* FROM "+Domain.SCHEMA+".TB_PARCELA p"
			+ " INNER JOIN "+Domain.SCHEMA+".RL_LANCAMENTO_PARCELA RL ON RL.COD_PARCELA = p.COD_PARCELA"
			+ " WHERE RL.COD_LANCAMENTO      = :codLancamento" 
			+ " ORDER BY p.DAT_PARCELA", nativeQuery = true)	
	List<Parcela> findByFatura(@Param("codLancamento") Integer codLancamento);

	@Modifying
	@Transactional
	@Query(value =  " INSERT INTO "+Domain.SCHEMA+".RL_LANCAMENTO_PARCELA (COD_LANCAMENTO, COD_PARCELA) \r\n" + 
					" VALUES (:codLancamento, :codParcela)  \r\n" + 
					" ON DUPLICATE KEY UPDATE COD_PARCELA = COD_PARCELA" , nativeQuery = true)	
	int saveLancamentoParcela(@Param("codLancamento") Integer codLancamento, @Param("codParcela") Integer codParcela);
	
	
	
	
}
