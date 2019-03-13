package br.com.maruno.scaf.resource;

import java.util.Map;
import java.util.TreeMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import br.com.maruno.api.annotation.ApiRestController;
import br.com.maruno.api.resources.ApiResourceSupport;
import br.com.maruno.api.service.TokenService;
import br.com.maruno.scaf.service.ParametrosService;
  
@ApiRestController("/api")
public class ParametrosResource extends ApiResourceSupport {
	
	@Autowired
	private ParametrosService parametrosService;

	@Autowired
	private TokenService tokenService;
	
	@GetMapping("/grupos")
	@ResponseBody
	public ResponseEntity<?> findGrupos() { 
		return ok(parametrosService.findGrupos());
	}
	
	@GetMapping("/categorias")
	@ResponseBody
	public ResponseEntity<?> findCategorias(@RequestParam(name = "codGrupo", required = false) Integer codGrupo) { 
		return ok(parametrosService.findCategorias(codGrupo));
	}
	
	@GetMapping("/periodos")
	@ResponseBody
	public ResponseEntity<?> findPeriodos() { 
		return ok(parametrosService.findPeriodos());
	}
	
	@GetMapping("/usuarios/logado")
	@ResponseBody
	public ResponseEntity<?> getUsuario() { 
		return ok(tokenService.getUsuario());
	}

	@GetMapping("/teste")
	@ResponseBody
	public ResponseEntity<?> teste() { 
		Map<String, Object> map = new TreeMap<String, Object>();
		map.put("grupos", parametrosService.findGrupos());
		map.put("periodos", parametrosService.findPeriodos());
		map.put("data", new java.util.Date());
		return ok(map);
	}
}
