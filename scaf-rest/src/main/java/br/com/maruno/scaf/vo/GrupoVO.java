package br.com.maruno.scaf.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import br.com.maruno.scaf.domain.Categoria;
 
public class GrupoVO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer codigo;  
	
	private String nome;  

	private List<Categoria> listCategorias = new ArrayList<Categoria>();
	
	public GrupoVO() {}

	public GrupoVO(Integer codigo, String nome, List<Categoria> listCategorias) {
		super();
		this.codigo = codigo;
		this.nome = nome;
		this.listCategorias = listCategorias;
	}

	public Integer getCodigo() {
		return codigo;
	}

	public void setCodigo(Integer codigo) {
		this.codigo = codigo;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public List<Categoria> getListCategorias() {
		return listCategorias;
	}

	public void setListCategorias(List<Categoria> listCategorias) {
		this.listCategorias = listCategorias;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("{codigo:");
		builder.append(codigo);
		builder.append(", nome:");
		builder.append(nome);
		builder.append(", listCategorias:");
		builder.append(listCategorias);
		builder.append("}");
		return builder.toString();
	}
	
	
	 
}
