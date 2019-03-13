package br.com.maruno.scaf.resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
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
import br.com.maruno.api.support.ApiDateUtils;
import br.com.maruno.scaf.domain.CartaoCredito;
import br.com.maruno.scaf.service.CartaoCreditoService;
import br.com.maruno.scaf.service.LancamentoService;
  
@ApiRestController("/api/cartoes")
public class CartaoCreditoResource extends ApiResourceSupport {
	
	@Autowired
	private CartaoCreditoService cartaoCreditoService;

	@Autowired
	private LancamentoService lancamentoService;
	
	@GetMapping 
	@ResponseBody
	public ResponseEntity<?> find() { 
		return ok(cartaoCreditoService.find());
	}
	
	@GetMapping("/ativos")
	@ResponseBody
	public ResponseEntity<?> findAtivos() { 
		return ok(cartaoCreditoService.findAtivos());
	}

	@PostMapping
	@ResponseBody
	public ResponseEntity<?> save(@RequestBody CartaoCredito cartaoCredito) {
		cartaoCreditoService.save(null, cartaoCredito);
		return post();
	}

	@PutMapping("/{codigo}")
	@ResponseBody
	public ResponseEntity<Void> save(@PathVariable("codigo") Integer codigo, @RequestBody CartaoCredito cartaoCredito) {
		cartaoCreditoService.save(codigo, cartaoCredito);
		return ok();
	}

	@PutMapping("/{codigo}/ativar")
	@ResponseBody
	public ResponseEntity<Void> ativar(@PathVariable("codigo") Integer codigo) {
		cartaoCreditoService.alterarStatus(codigo, true);
		return ok();
	}
	
	@PutMapping("/{codigo}/desativar")
	@ResponseBody
	public ResponseEntity<Void> desativar(@PathVariable("codigo") Integer codigo) {
		cartaoCreditoService.alterarStatus(codigo, false);
		return ok();
	}

	@DeleteMapping("/{codigo}")
	public ResponseEntity<Void> remove(@PathVariable("codigo") Integer codigo) {
		cartaoCreditoService.remove(codigo);
		return ok();
	}
	
	/************************************************************************************
	 * FIND FATURAS DE CARTAO 
	 ************************************************************************************/
	@GetMapping("/{codCartaoCredito}/faturas")
	@ResponseBody
	public ResponseEntity<?> findFaturas(@PathVariable("codCartaoCredito") Integer codCartaoCredito, @RequestParam(name = "anoMes", required = false) String anoMes) { 
		return ok(lancamentoService.findFaturas(codCartaoCredito, anoMes));  
	}
	
	/************************************************************************************
	 * FIND DATAS DAS FATURAS DE CARTAO 
	 ************************************************************************************/
	@GetMapping("/{codCartaoCredito}/faturas/datas")
	@ResponseBody
	public ResponseEntity<?> findDatasFaturas(@PathVariable("codCartaoCredito") Integer codCartaoCredito) { 
		return ok(lancamentoService.findDatasFaturas(codCartaoCredito));  
	}

	/************************************************************************************
	 * FIND PARCELAS DE FATURA DE CARTAO 
	 ************************************************************************************/
	@GetMapping("/{codCartaoCredito}/faturas/{data}/parcelas")
	@ResponseBody
	public ResponseEntity<?> findParcelasByParametros(@PathVariable("codCartaoCredito") Integer codCartaoCredito
                                                    , @PathVariable("data") String data) { 
		return ok(lancamentoService.findParcelasByParametros(codCartaoCredito, ApiDateUtils.convertStringDate(data, ApiDateUtils.YYYY_MM_DD)));  
	}
}
