package br.com.maruno.scaf.persistence;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import br.com.maruno.scaf.domain.Tag;
  
public interface TagDao extends JpaRepository<Tag, Integer> { 
	
	@Query("SELECT o FROM Tag o WHERE o.excluido = false AND o.codUsuario = :codUsuario")
	List<Tag> find(@Param("codUsuario") Integer codUsuario);
	
	@Modifying
	@Transactional
	@Query(value = "UPDATE Tag SET excluido = true, dataAlteracao = :dataAtualizacao WHERE codUsuario = :codUsuario AND codigo = :codigo ")
	int remove(@Param("codUsuario") Integer codUsuario, @Param("codigo") Integer codigo, @Param("dataAtualizacao") Date dataAtualizacao);
}
