package br.com.maruno.scaf.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.maruno.api.exceptions.DadoInconsistenteException;
import br.com.maruno.api.service.TokenService;
import br.com.maruno.api.support.ApiUtil;
import br.com.maruno.scaf.domain.Agendamento;
import br.com.maruno.scaf.persistence.AgendamentoDao;
 
@Service
public class AgendamentoService {

	@Autowired
	private AgendamentoDao agendamentoDao;
	
	@Autowired
	private TokenService tokenService;
	

	public List<Agendamento> find(){ 
		return agendamentoDao.find(tokenService.getCodUsuario());
	}
	
	public List<Agendamento> findAtivos(){ 
		return agendamentoDao.findAtivos(tokenService.getCodUsuario());
	}

	public Agendamento findById(Integer codigo){ 
		return agendamentoDao.findByCodigoAndCodUsuario(codigo, tokenService.getCodUsuario());
	}
	
	public void save(Integer codigo, Agendamento agendamento){
		if(ApiUtil.isNotEmpty(codigo)) {
			if(ApiUtil.isEmpty(agendamento.getCodigo())) {
				throw new DadoInconsistenteException("O código é obrigatório");
			}else if(!agendamento.getCodigo().equals(codigo)) {
				throw new DadoInconsistenteException("O codigo informado não corresponde ao registro selecionado!");
			}
		}
		if(ApiUtil.isEmpty(agendamento.getNome())) {
			throw new DadoInconsistenteException("O campo \"Nome\" é obrigatório");
		}
		if(ApiUtil.isEmpty(agendamento.getDataInicio())) {
			throw new DadoInconsistenteException("O campo \"Data Início\" é obrigatório");
		}
		if(agendamento.getCategoria() == null || ApiUtil.isEmpty(agendamento.getCategoria().getCodigo())){
			throw new DadoInconsistenteException("O campo \"Categoria\" é obrigatório");
		}
		if(agendamento.getPeriodo() == null || ApiUtil.isEmpty(agendamento.getPeriodo().getNumero())){
			throw new DadoInconsistenteException("O campo \"Período\" é obrigatório");
		} 
		agendamento.setCodUsuario(tokenService.getCodUsuario());
		agendamentoDao.save(agendamento);
	}
	
	public void remove(Integer codigo){ 
		agendamentoDao.remove(tokenService.getCodUsuario(), codigo, new Date());
	}
	
	public void alterarStatus(Integer codigo, boolean ativo){ 
		agendamentoDao.alterarStatus(tokenService.getCodUsuario(), codigo, new Date(), ativo);
	}
	
}
