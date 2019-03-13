package br.com.maruno.scaf.resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import br.com.maruno.api.annotation.ApiRestController;
import br.com.maruno.api.resources.ApiResourceSupport;
import br.com.maruno.scaf.service.DashBoardService;
  
@ApiRestController("/api/dashBoard")
public class DashBoardResource extends ApiResourceSupport {
	
	@Autowired
	private DashBoardService dashBoardService;
	
	@GetMapping 
	@ResponseBody
	public ResponseEntity<?> findDashBoard() { 
		return ok(dashBoardService.findDashBoard());
	} 
	
	@GetMapping("/lancamentos")
	@ResponseBody
	public ResponseEntity<?> findRelacaoLancamentos(@RequestParam(name = "codTipo", required = true) Integer codTipo) { 
		return ok(dashBoardService.findRelacaoLancamentos(codTipo));
	} 
}
