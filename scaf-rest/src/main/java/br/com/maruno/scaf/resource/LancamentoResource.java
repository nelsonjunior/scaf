package br.com.maruno.scaf.resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import br.com.maruno.api.annotation.ApiRestController;
import br.com.maruno.api.resources.ApiResourceSupport;
import br.com.maruno.scaf.domain.Lancamento;
import br.com.maruno.scaf.service.LancamentoService;
  
@ApiRestController("/api")
@CrossOrigin(origins = "*")
public class LancamentoResource extends ApiResourceSupport {
	
	@Autowired
	private LancamentoService lancamentoService;

	/************************************************************************************
	 * FIND LANCAMENTOS 
	 ************************************************************************************/
	@GetMapping("/lancamentos")
	@ResponseBody
	public ResponseEntity<?> find(@RequestParam(name = "codLancamento", required = false) Integer codLancamento
			                    , @RequestParam(name = "codGrupo",      required = false) Integer codGrupo
			                    , @RequestParam(name = "codCategoria",  required = false) Integer codCategoria
			                    , @RequestParam(name = "dataInicio",    required = true)  String  dataInicio
			                    , @RequestParam(name = "dataFim",       required = true)  String  dataFim
			                    , @RequestParam(name = "descricao",     required = false) String  descricao) { 
		return ok(lancamentoService.findByParametros(codLancamento, codGrupo, codCategoria, dataInicio, dataFim, descricao));  
	}

	/************************************************************************************
	 * FIND LANCAMENTO BY ID
	 ************************************************************************************/
	@GetMapping("/lancamentos/{codigo}")
	@ResponseBody
	public ResponseEntity<?> find(@PathVariable("codigo") Integer codigo) { 
		return ok(lancamentoService.findById(codigo)); 
	}

	/************************************************************************************
	 * SAVE LANCAMENTO
	 ************************************************************************************/
	@PostMapping("/lancamentos")
	@ResponseBody
	public ResponseEntity<?> saveLancamento(@RequestParam(name = "numParcelas", required = false) Integer numParcelas, @RequestBody Lancamento lancamento) {
		lancamentoService.saveLancamento(lancamento, numParcelas);
		return post();
	}
	
	/************************************************************************************
	 * SAVE LANCAMENTO AGENDADO 
	 ************************************************************************************/
	@PostMapping("/lancamentos/agendados")
	@ResponseBody
	public ResponseEntity<?> saveLancamentoAgendado(@RequestParam(name = "numParcelas", required = false) Integer numParcelas, @RequestBody Lancamento lancamento) {
		lancamentoService.saveLancamentoAgendado(lancamento, numParcelas);
		return post();
	} 

	/************************************************************************************
	 * SAVE LANCAMENTO FATURA 
	 ************************************************************************************/
	@PostMapping("/lancamentos/faturas")
	@ResponseBody
	public ResponseEntity<?> saveLancamentoFatura(@RequestBody Lancamento lancamento) {
		lancamentoService.saveLancamentoFatura(lancamento);
		return post();
	} 
	
	/************************************************************************************
	 * FIND PARCELAS LANCAMENTO FATURA 
	 ************************************************************************************/
	@GetMapping("/lancamentos/faturas/{codLancamento}/parcelas")
	@ResponseBody
	public ResponseEntity<?> findParcelasByFatura(@PathVariable("codLancamento") Integer codLancamento) {
		return ok(lancamentoService.findParcelasByFatura(codLancamento));
	} 

	/************************************************************************************
	 * UPDATE LANCAMENTO
	 ************************************************************************************/
	@PutMapping("/lancamentos/{codigo}")
	@ResponseBody
	public ResponseEntity<Void> save(@PathVariable("codigo") Integer codigo, @RequestBody Lancamento lancamento) {
		lancamentoService.updateLancamento(codigo, lancamento);
		return ok();
	}

	/************************************************************************************
	 * REMOVE LANCAMENTO
	 ************************************************************************************/
	@DeleteMapping("/lancamentos/{codigo}")
	public ResponseEntity<Void> remove(@PathVariable("codigo") Integer codigo) {
		lancamentoService.remove(codigo);
		return ok();
	} 


	/*+**********************************************************************************
	 * FIND PARCELA BY ID
	 ************************************************************************************/
	@GetMapping("/parcelas/{codigo}")
	@ResponseBody
	public ResponseEntity<?> findParcelaById(@PathVariable("codigo") Integer codigo) { 
		return ok(lancamentoService.findParcelaById(codigo)); 
	}

	/*+**********************************************************************************
	 * FIND PARCELAS PAGAS
	 ************************************************************************************/
	@GetMapping("/parcelas/pagas")
	@ResponseBody
	public ResponseEntity<?> findParcelasPagas(@RequestParam(name = "anoMes", required = false) String anoMes) { 
		return ok(lancamentoService.findParcelasPagas(anoMes)); 
	}
	
	/*+**********************************************************************************
	 * FIND PARCELAS PENDENTES
	 ************************************************************************************/
	@GetMapping("/parcelas/pendentes")
	@ResponseBody
	public ResponseEntity<?> findParcelasPendentes(@RequestParam(name = "anoMes", required = false) String anoMes) { 
		return ok(lancamentoService.findParcelasPendentes(anoMes)); 
	}

	/*+**********************************************************************************
	 * FIND DATAS PARCELAS PENDENTES
	 ************************************************************************************/
	@GetMapping("/parcelas/pendentes/datas")
	@ResponseBody
	public ResponseEntity<?> findDatasParcelasPendentes() { 
		return ok(lancamentoService.findDatasParcelasPendentes()); 
	}
}
