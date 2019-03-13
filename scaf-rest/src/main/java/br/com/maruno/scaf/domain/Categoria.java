package br.com.maruno.scaf.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
 
@Entity
@Table(name = "TB_CATEGORIA", schema = Domain.SCHEMA)
public class Categoria extends Domain {
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name = "COD_CATEGORIA")
	private Integer codigo;  
	
	@Column(name = "NOM_CATEGORIA")
	private String nome;  
	
	@JsonIgnore
	@Column(name = "IND_ATIVO")
	private boolean ativo = true;

	@ManyToOne
	@JoinColumn(name = "COD_GRUPO")
	private Grupo grupo;
	
	public Categoria() {}
	
	public Categoria(Integer codigo) {
		this.codigo = codigo;
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

	public boolean isAtivo() {
		return ativo;
	}

	public void setAtivo(boolean ativo) {
		this.ativo = ativo;
	}

	public Grupo getGrupo() {
		return grupo;
	}

	public void setGrupo(Grupo grupo) {
		this.grupo = grupo;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("{codigo:");
		builder.append(codigo);
		builder.append(", nome:");
		builder.append(nome);
		builder.append(", ativo:");
		builder.append(ativo);
		builder.append(", grupo:");
		builder.append(grupo);
		builder.append("}");
		return builder.toString();
	}
  
  
}
