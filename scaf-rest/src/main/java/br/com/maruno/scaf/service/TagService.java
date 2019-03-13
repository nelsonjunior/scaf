package br.com.maruno.scaf.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.maruno.api.exceptions.DadoInconsistenteException;
import br.com.maruno.api.service.TokenService;
import br.com.maruno.api.support.ApiUtil;
import br.com.maruno.scaf.domain.Tag;
import br.com.maruno.scaf.persistence.TagDao; 
 
@Service
public class TagService {

	@Autowired
	private TagDao tagDao;
 
	
	@Autowired
	private TokenService tokenService;

	public List<Tag> find(){ 
		return tagDao.find(tokenService.getCodUsuario());
	}
	
	public void save(Integer codigo, Tag tag){
		if(ApiUtil.isNotEmpty(codigo)) {
			if(ApiUtil.isEmpty(tag.getCodigo())) {
				throw new DadoInconsistenteException("O código é obrigatório");
			}else if(!tag.getCodigo().equals(codigo)) {
				throw new DadoInconsistenteException("O codigo informado não corresponde ao registro selecionado!");
			}
			tag.setDataAlteracao(new Date());
		}
		if(ApiUtil.isEmpty(tag.getNome())) {
			throw new DadoInconsistenteException("O \"Nome\" é obrigatório");
		}
		tag.setNome(tag.getNome().replaceAll(";", ""));
		tag.setCodUsuario(tokenService.getCodUsuario());
		tagDao.save(tag);
	}
	
	public void remove(Integer codigo){ 
		tagDao.remove(tokenService.getCodUsuario(), codigo, new Date());
	} 
	
	
}
