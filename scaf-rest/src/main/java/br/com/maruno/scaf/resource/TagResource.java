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
import br.com.maruno.scaf.domain.Tag;
import br.com.maruno.scaf.service.TagService;
  
@ApiRestController("/api/tags")
public class TagResource extends ApiResourceSupport {
	
	@Autowired
	private TagService tagService;
	
	@GetMapping 
	@ResponseBody
	public ResponseEntity<?> find() { 
		return ok(tagService.find());
	}

	@PostMapping
	@ResponseBody
	public ResponseEntity<?> save(@RequestBody Tag tag) {
		tagService.save(null, tag);
		return post();
	}

	@PutMapping("/{codigo}")
	@ResponseBody
	public ResponseEntity<Void> save(@PathVariable("codigo") Integer codigo, @RequestBody Tag tag) {
		tagService.save(codigo, tag);
		return ok();
	}

	@DeleteMapping("/{codigo}")
	public ResponseEntity<Void> remove(@PathVariable("codigo") Integer codigo) {
		tagService.remove(codigo);
		return ok();
	}
}
