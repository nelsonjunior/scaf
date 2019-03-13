package br.com.maruno.scaf.persistence;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import br.com.maruno.scaf.domain.Contato;
import br.com.maruno.scaf.domain.Domain;
   
 
/**
 * @Aplicativo 
 * @Modulo quaemo-scaf
 * @Autor <a href="mailto:jackmaruno@gmail.com">Willian.Maruno</a>
 * @Data 11 de set de 2018 12:59:51
 * @Pacote br.com.quaemo.scaf.persistence
 * @Nome ContatoDao.java
 * @NomeCompleto br.com.quaemo.scaf.persistence.ContatoDao.java
 */
public interface ContatoDao extends JpaRepository<Contato, Integer> { 

	@Query("SELECT o FROM Contato o WHERE o.excluido = false ")
	List<Contato> find();
	

	@Modifying
	@Transactional
	@Query(value = "UPDATE "+Domain.SCHEMA+".TB_CONTATO SET IND_EXCLUIDO = 1 WHERE COD_CONTATO = :codigo ", nativeQuery = true)
	int remove(@Param("codigo") Integer codigo);
}
