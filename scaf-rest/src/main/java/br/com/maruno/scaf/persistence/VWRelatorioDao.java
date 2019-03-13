package br.com.maruno.scaf.persistence;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import br.com.maruno.scaf.domain.VWRelatorio;
   
/**
 * @Aplicativo 
 * @Modulo scaf-rest
 * @Autor <a href="mailto:jackmaruno@gmail.com">Willian.Maruno</a>
 * @Pacote br.com.maruno.scaf.persistence
 * @Nome VWRelatorioDao.java
 * @NomeCompleto br.com.maruno.scaf.persistence.VWRelatorioDao.java
 */
public interface VWRelatorioDao extends JpaRepository<VWRelatorio, Integer> { 

	List<VWRelatorio> findByCodUsuario(Integer codUsuario);

	@Query(" SELECT DISTINCT l.anoMes FROM VWRelatorio l WHERE l.codUsuario = :codUsuario" )
	List<String> findCompetencias(@Param("codUsuario") Integer codUsuario);
}
