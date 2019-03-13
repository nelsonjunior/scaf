package br.com.maruno.scaf.persistence;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import br.com.maruno.scaf.domain.Categoria;
   
/**
 * @Aplicativo 
 * @Modulo quaemo-scaf
 * @Autor <a href="mailto:jackmaruno@gmail.com">Willian.Maruno</a>
 * @Data 11 de set de 2018 12:56:28
 * @Pacote br.com.quaemo.scaf.persistence
 * @Nome CategoriaDao.java
 * @NomeCompleto br.com.quaemo.scaf.persistence.CategoriaDao.java
 */
public interface CategoriaDao extends JpaRepository<Categoria, Integer> { 

	@Query("SELECT o FROM Categoria o WHERE o.ativo = true ORDER BY o.nome ")
	List<Categoria> findAtivos();
	
	@Query("SELECT o FROM Categoria o WHERE o.ativo = true AND o.grupo.codigo = :codGrupo ORDER BY o.nome")
	List<Categoria> findAtivosByGrupo(@Param("codGrupo") Integer codGrupo);
}
