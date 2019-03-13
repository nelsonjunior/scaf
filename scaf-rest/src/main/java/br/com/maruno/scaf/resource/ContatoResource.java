package br.com.maruno.scaf.resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import br.com.maruno.api.annotation.ApiRestController;
import br.com.maruno.api.resources.ApiResourceSupport;
import br.com.maruno.scaf.service.ContatoService;
  
@ApiRestController("/api/contatos")
public class ContatoResource extends ApiResourceSupport {
	
	@Autowired
	private ContatoService contatoService;
	
	@GetMapping 
	@ResponseBody
	public ResponseEntity<?> find() { 
		return ok(contatoService.find());
	}   

	@DeleteMapping("/{codigo}")
	public ResponseEntity<Void> remove(@PathVariable("codigo") Integer codigo) {
		contatoService.remove(codigo);
		return ok();
	}
}
