package br.com.maruno.scaf.resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import br.com.maruno.api.annotation.ApiRestController;
import br.com.maruno.api.resources.ApiResourceSupport;
import br.com.maruno.scaf.service.RelatorioService;
  
@ApiRestController("/api/relatorios")
public class RelatorioResource extends ApiResourceSupport {
	
	@Autowired
	private RelatorioService relatorioService;
	
	@GetMapping 
	@ResponseBody
	public ResponseEntity<?> findRelatorio() { 
		return ok(relatorioService.findRelatorio());
	} 
	
	@GetMapping("/agrupados")
	@ResponseBody
	public ResponseEntity<?> findRelatorioAgrupado() { 
		return ok(relatorioService.findRelatorioAgrupado());
	} 
}
