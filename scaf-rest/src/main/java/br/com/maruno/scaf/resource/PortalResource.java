package br.com.maruno.scaf.resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import br.com.maruno.api.annotation.ApiRestController;
import br.com.maruno.api.resources.ApiResourceSupport;
import br.com.maruno.scaf.domain.Contato;
import br.com.maruno.scaf.service.ContatoService;
  
@ApiRestController("/api/portal")
public class PortalResource extends ApiResourceSupport {
	
	@Autowired
	private ContatoService contatoService;
	

	/************************************************************************************
	 * SAVE CONTATO
	 ************************************************************************************/
	@PostMapping("/contatos")
	@ResponseBody
	public ResponseEntity<?> saveContato(@RequestBody Contato contato) {
		contatoService.save(contato);
		return post();
	} 
}
