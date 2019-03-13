package br.com.maruno.scaf.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.maruno.api.support.ApiUtil;
import br.com.maruno.scaf.domain.Categoria;
import br.com.maruno.scaf.domain.Grupo;
import br.com.maruno.scaf.domain.Periodo;
import br.com.maruno.scaf.persistence.CategoriaDao;
import br.com.maruno.scaf.persistence.GrupoDao;
import br.com.maruno.scaf.persistence.PeriodoDao;
import br.com.maruno.scaf.vo.GrupoVO;
  
@Service
public class ParametrosService {

	@Autowired
	private PeriodoDao periodoDao;

	@Autowired
	private GrupoDao grupoDao;

	@Autowired
	private CategoriaDao categoriaDao; 
	 
	
	public List<Categoria> findCategorias(Integer codGrupo){ 
		if(ApiUtil.isEmpty(codGrupo)) { 
			return categoriaDao.findAtivos();
		}
		return categoriaDao.findAtivosByGrupo(codGrupo);
	}
	
	public List<GrupoVO> findGrupos(){ 
		List<GrupoVO> lista = new ArrayList<GrupoVO>();
		for(Grupo grupo: grupoDao.findAtivos()) {
			lista.add(new GrupoVO(grupo.getCodigo(), grupo.getNome(), categoriaDao.findAtivosByGrupo(grupo.getCodigo())));  
		}
		return lista;
	}
	
	public List<Periodo> findPeriodos(){ 
		return periodoDao.findAll();
	}
	
}
