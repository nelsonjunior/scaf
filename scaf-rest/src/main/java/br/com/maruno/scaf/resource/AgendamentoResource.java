package br.com.maruno.scaf.resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import br.com.maruno.api.annotation.ApiRestController;
import br.com.maruno.api.resources.ApiResourceSupport;
import br.com.maruno.scaf.domain.Agendamento;
import br.com.maruno.scaf.service.AgendamentoService;
  
@ApiRestController("/api/agendamentos")
public class AgendamentoResource extends ApiResourceSupport {
	
	@Autowired
	private AgendamentoService agendamentoService;
	
	@GetMapping 
	@ResponseBody
	public ResponseEntity<?> find() { 
		return ok(agendamentoService.find());
	}
	
	@GetMapping("/ativos")
	@ResponseBody
	public ResponseEntity<?> findAtivos() { 
		return ok(agendamentoService.findAtivos());
	}

	@PostMapping
	@ResponseBody
	public ResponseEntity<?> save(@RequestBody Agendamento agendamento) {
		agendamentoService.save(null, agendamento);
		return post();
	}

	@PutMapping("/{codigo}")
	@ResponseBody
	public ResponseEntity<Void> save(@PathVariable("codigo") Integer codigo, @RequestBody Agendamento agendamento) {
		agendamentoService.save(codigo, agendamento);
		return ok();
	}

	@PutMapping("/{codigo}/ativar")
	@ResponseBody
	public ResponseEntity<Void> ativar(@PathVariable("codigo") Integer codigo) {
		agendamentoService.alterarStatus(codigo, true);
		return ok();
	}
	
	@PutMapping("/{codigo}/desativar")
	@ResponseBody
	public ResponseEntity<Void> desativar(@PathVariable("codigo") Integer codigo) {
		agendamentoService.alterarStatus(codigo, false);
		return ok();
	}

	@DeleteMapping("/{codigo}")
	public ResponseEntity<Void> remove(@PathVariable("codigo") Integer codigo) {
		agendamentoService.remove(codigo);
		return ok();
	}
}
