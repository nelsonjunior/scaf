package br.com.maruno.scaf.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.maruno.api.exceptions.DadoInconsistenteException;
import br.com.maruno.api.service.TokenService;
import br.com.maruno.api.support.ApiUtil;
import br.com.maruno.scaf.domain.CartaoCredito;
import br.com.maruno.scaf.persistence.CartaoCreditoDao;
 
@Service
public class CartaoCreditoService {

	@Autowired
	private CartaoCreditoDao cartaoCreditoDao;
 
	
	@Autowired
	private TokenService tokenService;

	public List<CartaoCredito> find(){ 
		return cartaoCreditoDao.find(tokenService.getCodUsuario());
	}
	
	public CartaoCredito findById(Integer codigo){ 
		return cartaoCreditoDao.findByCodigoAndCodUsuario(codigo, tokenService.getCodUsuario());
	}
	
	public List<CartaoCredito> findAtivos(){ 
		return cartaoCreditoDao.findAtivos(tokenService.getCodUsuario());
	}
	
	public void save(Integer codigo, CartaoCredito cartaoCredito){
		if(ApiUtil.isNotEmpty(codigo)) {
			if(ApiUtil.isEmpty(cartaoCredito.getCodigo())) {
				throw new DadoInconsistenteException("O código é obrigatório");
			}else if(!cartaoCredito.getCodigo().equals(codigo)) {
				throw new DadoInconsistenteException("O codigo informado não corresponde ao registro selecionado!");
			}
		}
		if(ApiUtil.isEmpty(cartaoCredito.getNome())) {
			throw new DadoInconsistenteException("O campo \"Nome\" é obrigatório");
		}
		if(ApiUtil.isEmpty(cartaoCredito.getBandeira())) {
			throw new DadoInconsistenteException("O campo \"Bandeira\" é obrigatório");
		}
		if(ApiUtil.isEmpty(cartaoCredito.getVencimento())) {
			throw new DadoInconsistenteException("O campo \"Vencimento\" é obrigatório");
		}
		if(ApiUtil.isEmpty(cartaoCredito.getFechamento())) {
			throw new DadoInconsistenteException("O campo \"Fechamento\" é obrigatório");
		}
		cartaoCredito.setCodUsuario(tokenService.getCodUsuario());
		cartaoCreditoDao.save(cartaoCredito);
	}
	
	public void remove(Integer codigo){ 
		cartaoCreditoDao.remove(tokenService.getCodUsuario(), codigo, new Date());
	}
	
	public void alterarStatus(Integer codigo, boolean ativo){ 
		cartaoCreditoDao.alterarStatus(tokenService.getCodUsuario(), codigo, new Date(), ativo);
	}
	
}
