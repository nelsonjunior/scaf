package br.com.maruno.scaf.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.maruno.api.exceptions.DadoInconsistenteException;
import br.com.maruno.api.support.ApiUtil;
import br.com.maruno.scaf.domain.Contato;
import br.com.maruno.scaf.persistence.ContatoDao;
 
@Service
public class ContatoService {

	@Autowired
	private ContatoDao contatoDao; 
	

	public List<Contato> find(){ 
		return contatoDao.find();
	} 
	
	public void save(Contato contato){ 
		if(ApiUtil.isEmpty(contato.getNome())) {
			throw new DadoInconsistenteException("O campo \"Nome\" é obrigatório");
		}
		if(ApiUtil.isEmpty(contato.getAssunto())) {
			throw new DadoInconsistenteException("O campo \"Assunto\" é obrigatório");
		} 
		if(ApiUtil.isEmpty(contato.getEmail())) {
			throw new DadoInconsistenteException("O campo \"E-mail\" é obrigatório");
		} 
		if(ApiUtil.isEmpty(contato.getMensagem())) {
			throw new DadoInconsistenteException("O campo \"Mensagem\" é obrigatório");
		} 
		contatoDao.save(contato);
	}
	
	public void remove(Integer codigo){ 
		contatoDao.remove(codigo);
	} 
	
}
