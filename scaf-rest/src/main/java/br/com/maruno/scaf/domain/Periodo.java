package br.com.maruno.scaf.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
 
@Entity
@Table(name = "TB_PERIODO", schema = Domain.SCHEMA)
public class Periodo extends Domain {
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name = "NUM_PERIODO")
	private Integer numero;  
	
	@Column(name = "NOM_PERIODO")
	private String nome;  
 
	
	public Periodo() {}
	
	public Periodo(Integer numero) {
		this.numero = numero;
	}

	public Integer getNumero() {
		return numero;
	}

	public void setNumero(Integer numero) {
		this.numero = numero;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("{numero:");
		builder.append(numero);
		builder.append(", nome:");
		builder.append(nome);
		builder.append("}");
		return builder.toString();
	}
  
}
