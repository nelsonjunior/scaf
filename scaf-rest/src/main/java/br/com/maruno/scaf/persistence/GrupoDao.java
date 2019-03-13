package br.com.maruno.scaf.persistence;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import br.com.maruno.scaf.domain.Grupo;
  
/**
 * @Aplicativo 
 * @Modulo quaemo-scaf
 * @Autor <a href="mailto:jackmaruno@gmail.com">Willian.Maruno</a>
 * @Data 11 de set de 2018 12:56:01
 * @Pacote br.com.quaemo.scaf.persistence
 * @Nome GrupoDao.java
 * @NomeCompleto br.com.quaemo.scaf.persistence.GrupoDao.java
 */
public interface GrupoDao extends JpaRepository<Grupo, Integer> { 

	@Query("SELECT o FROM Grupo o WHERE o.ativo = true  ORDER BY o.nome")
	List<Grupo> findAtivos();
}
