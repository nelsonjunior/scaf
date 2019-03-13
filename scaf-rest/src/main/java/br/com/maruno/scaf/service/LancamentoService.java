package br.com.maruno.scaf.service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import br.com.maruno.api.exceptions.DadoInconsistenteException;
import br.com.maruno.api.service.TokenService;
import br.com.maruno.api.support.ApiDateUtils;
import br.com.maruno.api.support.ApiUtil;
import br.com.maruno.scaf.domain.Lancamento;
import br.com.maruno.scaf.domain.Parcela;
import br.com.maruno.scaf.enums.TipoPagamentoEnum;
import br.com.maruno.scaf.persistence.LancamentoDao;
import br.com.maruno.scaf.persistence.ParcelaDao;
import br.com.maruno.scaf.vo.DataFaturaVO;
import br.com.maruno.scaf.vo.DataParcelaVO;
 
@Service
public class LancamentoService {

	@Autowired
	private LancamentoDao lancamentoDao;
	
	@Autowired
	private ParcelaDao parcelaDao;
	
	@Autowired
	private TokenService tokenService;
	
	@Autowired
	private CartaoCreditoService cartaoCreditoService;
	
	@Autowired
	private AgendamentoService agendamentoService;
	

	/************************************************************************************
	 * FIND ALL LANCAMENTOS 
	 ************************************************************************************/
	public List<Lancamento> findAll(){ 
		return lancamentoDao.findByCodUsuario(tokenService.getCodUsuario());
	} 

	/************************************************************************************
	 * FIND LANCAMENTO BY ID
	 ************************************************************************************/
	public Lancamento findById(Integer codLancamento){ 
		Lancamento lancamento = lancamentoDao.findByCodigoAndCodUsuario(codLancamento, tokenService.getCodUsuario());
		if(TipoPagamentoEnum.in(lancamento.getCodTipoPagamento(), TipoPagamentoEnum.PARCELADO, TipoPagamentoEnum.PARCELADO_CARTAO)) {
			lancamento.setListParcelas(findParcelasByLancamento(lancamento));
		}
		return lancamento;
	} 

	/************************************************************************************
	 * FIND LANCAMENTOS 
	 ************************************************************************************/
	public List<Lancamento> findByParametros(Integer codLancamento, Integer codGrupo, Integer codCategoria, String dataInicio, String dataFim, String descricao){ 
		Date d1 = ApiDateUtils.convertStringDate(dataInicio);
		Date d2 = ApiDateUtils.convertStringDate(dataFim);
		if(ApiUtil.isEmpty(descricao)){ 
			descricao = null;
		}else {
			descricao = descricao.toUpperCase().trim();
		}
		if(ApiUtil.isEmpty(d1) || ApiUtil.isEmpty(d2)){ 
			throw new DadoInconsistenteException("O \"Período\" não foi informado");
		}
		
		List<Lancamento> lista = lancamentoDao.findByParameters(codLancamento, codGrupo, codCategoria, d1, d2, descricao, tokenService.getCodUsuario());
		return lista;
	} 

	/************************************************************************************
	 * REMOVE LANCAMENTO
	 ************************************************************************************/
	@Transactional 
	public void remove(Integer codigo){ 
		lancamentoDao.remove(tokenService.getCodUsuario(), codigo);
	} 

	/************************************************************************************
	 * SAVE LANCAMENTO
	 ************************************************************************************/
	private static final int CAT_PARCELA = 46;

	@Transactional 
	public void saveLancamento(Lancamento lancamento, Integer numParcelas){
		validarLancamento(null, lancamento); 

		if(lancamento.getCategoria().getCodigo().equals(CAT_PARCELA)) { 
			if(lancamento.getParcela() == null || ApiUtil.isEmpty(lancamento.getParcela().getCodigo())){
				throw new DadoInconsistenteException("A parcela não foi informada");
			}
			lancamento.setParcela(parcelaDao.findOne(lancamento.getParcela().getCodigo()));
			lancamentoDao.updateValorRealizado(lancamento.getParcela().getCodLancamento(), lancamento.getValor());
		}
 		
		if(TipoPagamentoEnum.in(lancamento.getCodTipoPagamento(), TipoPagamentoEnum.PARCELADO, TipoPagamentoEnum.PARCELADO_CARTAO) 
				|| lancamento.getCategoria().getCodigo().equals(CAT_EMPRESTIMO)) {
			saveLancamentoParcelado(lancamento, numParcelas); 
		}else {
			if(ApiUtil.isEmpty(lancamento.getValorPrevisto())) {
				lancamento.setValorPrevisto(lancamento.getValor());
			} 
			lancamento.setCodUsuario(tokenService.getCodUsuario());
			lancamentoDao.save(lancamento);
			
		}
	} 
	 
	private void validarLancamento(Integer codigo, Lancamento lancamento) { 
		StringBuilder sb = new StringBuilder();
		
		if(ApiUtil.isNotEmpty(codigo) && ApiUtil.isEmpty(lancamento.getCodigo())){
			throw new DadoInconsistenteException("O ID do lançamento não foi informado");
		}
		if(ApiUtil.isEmpty(codigo) && ApiUtil.isNotEmpty(lancamento.getCodigo())){
			throw new DadoInconsistenteException("O lançamento informado já existe na base de dados");
		} 
		if ((ApiUtil.isNotEmpty(codigo) && ApiUtil.isNotEmpty(lancamento.getCodigo())) && !lancamento.getCodigo().equals(codigo)) {
			throw new DadoInconsistenteException("O ID informado não corresponde ao registro selecionado!");
		}
		if(ApiUtil.isNotEmpty(codigo)){
			Lancamento lancamentoBase = findById(codigo);
			if(lancamentoBase == null) {
				throw new DadoInconsistenteException("O lançamento informado não existe na base de dados");
			}
			if((lancamento.getCategoria() != null && ApiUtil.isNotEmpty(lancamento.getCategoria().getCodigo()))) {
				if(!lancamentoBase.getCategoria().getCodigo().equals(lancamento.getCategoria().getCodigo())) {
					sb.append(", Não é permitido alterar o campo \"Categoria\".");
				}
			}
			if(!lancamentoBase.getCodTipoPagamento().equals(lancamento.getCodTipoPagamento())) {
				sb.append(", Não é permitido alterar o campo \"Forma de Pagamento\".");
			}
		}
		if(lancamento.getCategoria() == null || ApiUtil.isEmpty(lancamento.getCategoria().getCodigo())){
			sb.append(", O campo \"Categoria\" é de preenchimento obrigatório.");
		}
		if(ApiUtil.isEmpty(lancamento.getDataReferencia())){
			sb.append(", O campo \"Data de Referência\" é de preenchimento obrigatório.");
		}
		if(ApiUtil.isEmpty(lancamento.getCodTipoPagamento())){
			sb.append(", O campo \"Forma de Pagamento\" é de preenchimento obrigatório.");
		}
		if(lancamento.getValor().compareTo(BigDecimal.ZERO) < 1){
			sb.append(", O campo \"Valor\" é de preenchimento obrigatório.");
		}
		if (ApiUtil.isNotEmpty(sb.toString())) {
			throw new DadoInconsistenteException(sb.toString());
		}
	}

	/************************************************************************************
	 * UPDATE LANCAMENTO
	 ************************************************************************************/
	@Transactional 
	public void updateLancamento(Integer codigo, Lancamento lancamento){
		if(ApiUtil.isEmpty(codigo) || ApiUtil.isEmpty(lancamento.getCodigo())){
			throw new DadoInconsistenteException("O lançamento informado não existe na base de dados");
		}
		validarLancamento(codigo, lancamento); 

		if(TipoPagamentoEnum.in(lancamento.getCodTipoPagamento(), TipoPagamentoEnum.PARCELADO, TipoPagamentoEnum.PARCELADO_CARTAO)) {
			throw new DadoInconsistenteException("Não é permitido alterar o lançamento com a forma de pagamento \""+TipoPagamentoEnum.getNome(lancamento.getCodTipoPagamento())+"\"."); 
			
		}else if(lancamento.getCategoria().getCodigo().equals(CAT_EMPRESTIMO)) {
			throw new DadoInconsistenteException("Não é permitido alterar o lançamento da categoria \"Empréstimo\"."); 
			
		}else if(lancamento.getCategoria().getCodigo().equals(CAT_FATURA)) {
			throw new DadoInconsistenteException("Não é permitido alterar o lançamento de Fatura."); 
		}else {
			if(ApiUtil.isEmpty(lancamento.getValorPrevisto())) {
				lancamento.setValorPrevisto(lancamento.getValor());
			} 
			Lancamento lancamentoBase = lancamentoDao.findOne(codigo);
			lancamentoBase.setValorPrevisto(lancamento.getValorPrevisto());
			lancamentoBase.setValor(lancamento.getValor());
			lancamentoBase.setTags(lancamento.getTags());
			lancamentoBase.setDescricao(lancamento.getDescricao());
			lancamentoBase.setDataReferencia(lancamento.getDataReferencia());
			lancamentoBase.setDataAlteracao(new Date());
			
			lancamentoDao.save(lancamentoBase);
			
		}
	} 
	
	/************************************************************************************
	 * SAVE LANCAMENTO PARCELADO 
	 ************************************************************************************/
	private static final int CAT_EMPRESTIMO = 63;
	
	private void saveLancamentoParcelado(Lancamento lancamento, Integer numParcelas) { 
		validarLancamentoParcelado(lancamento, numParcelas); 
		
		Date dataParcela = lancamento.getDataReferencia();
		BigDecimal valorParcela = lancamento.getValor();
		
		if(TipoPagamentoEnum.PARCELADO_CARTAO.is(lancamento.getCodTipoPagamento())){
			lancamento.setValor(BigDecimal.ZERO); 
			lancamento.setCartaoCredito(cartaoCreditoService.findById(lancamento.getCartaoCredito().getCodigo()));  
			dataParcela = getDataParcela(lancamento);
			
		}else if(lancamento.getCategoria().getCodigo().equals(CAT_EMPRESTIMO)){
			dataParcela = lancamento.getDataFatura();
			valorParcela = lancamento.getValorPrevisto(); 
			lancamento.setDataFatura(null);
			lancamento.setCartaoCredito(null); 
		}else {
			lancamento.setValor(BigDecimal.ZERO); 
			lancamento.setCartaoCredito(null); 
		}
		
		lancamento.setCodUsuario(tokenService.getCodUsuario()); 
		lancamento.setValorPrevisto(multiplicar(valorParcela, numParcelas)); 
		lancamentoDao.save(lancamento);
		for(int i = 0; i < numParcelas ; i++){
			Parcela p = new Parcela();
			p.setNumero(i+1); 
			p.setData(ApiDateUtils.addMeses(dataParcela, i));  
			p.setValor(valorParcela); 
			p.setCodLancamento(lancamento.getCodigo());
			parcelaDao.save(p); 
		}  
	}

	private void validarLancamentoParcelado(Lancamento lancamento, Integer numParcelas){
		StringBuilder sb = new StringBuilder();
		if(TipoPagamentoEnum.PARCELADO_CARTAO.is(lancamento.getCodTipoPagamento()) && (lancamento.getCartaoCredito() == null || lancamento.getCartaoCredito().getCodigo() == null)) {
			sb.append("O campo \"Cartão de Crédito\" é de preenchimento obrigatório.");
		}
		if(ApiUtil.isEmpty(numParcelas)){ 
			sb.append(", O campo \"Em quantas vezes\" é de preenchimento obrigatório.");
		}
		if (ApiUtil.isNotEmpty(sb.toString())) {
			throw new DadoInconsistenteException(sb.toString());
		}
	}

	private Date getDataParcela(Lancamento lancamento) {
		int vencimento = lancamento.getCartaoCredito().getVencimento();
		int fechamento = lancamento.getCartaoCredito().getFechamento();
		
		//compra no mesmo mes
		if(ApiDateUtils.getAnoMes(lancamento.getDataReferencia()) == ApiDateUtils.getAnoMes(new Date())){
			// verifica se a data e anterior ao fechamento do cartao
			if(ApiDateUtils.getDia(lancamento.getDataReferencia()) <= fechamento){ 
				return ApiDateUtils.getDate(lancamento.getDataReferencia(), vencimento, 1);
			}else{
				return ApiDateUtils.getDate(lancamento.getDataReferencia(), vencimento, 2);
			}
		//compra no mes anterior
		}else if(ApiDateUtils.getAnoMes(lancamento.getDataReferencia()) < ApiDateUtils.getAnoMes(new Date())){
			// verifica se a data e posterior ao fechamento do cartao
			if(ApiDateUtils.getDia(lancamento.getDataReferencia()) > fechamento){  
				return ApiDateUtils.getDate(lancamento.getDataReferencia(), vencimento, 2);
				
			// verifica se a fatura ja foi paga
			}else {
				String anoMes = ApiDateUtils.convertDateToString(lancamento.getDataReferencia(), "yyyyMM");
	 			List<Lancamento> lista = lancamentoDao.findLancamentosFaturas(tokenService.getCodUsuario(), lancamento.getCartaoCredito().getCodigo(), anoMes);
				if(ApiUtil.isNotEmpty(lista)) {
					String dataPagamento = ApiDateUtils.convertDateToString(lista.get(0).getDataReferencia(), "dd/MM/yyyy");
					throw new DadoInconsistenteException("Não é permitido efetuar lançamento no Cartão de Crédito \""+lancamento.getCartaoCredito().getNome()
							                            +"\", a fatura já foi paga em \""+dataPagamento+"\".");
				}else {
					return ApiDateUtils.getDate(lancamento.getDataReferencia(), vencimento, 1);
				}
			}

		//compra no mes posterior
		}else {
			throw new DadoInconsistenteException("Não é permitido efetuar lançamento no Cartão de Crédito \""+lancamento.getCartaoCredito().getNome()+"\" com data futura.");
		}
	}
 
	
	/************************************************************************************
	 * SAVE LANCAMENTO AGENDADO 
	 ************************************************************************************/

	@Transactional 
	public void saveLancamentoAgendado(Lancamento lancamento, Integer numParcelas) { 
		validarLancamento(null, lancamento); 

		List<Parcela> listParcelaFatura = null;
 		if(lancamento.getAgendamento() != null && ApiUtil.isNotEmpty(lancamento.getAgendamento().getCodigo())){
 	 		lancamento.setAgendamento(agendamentoService.findById(lancamento.getAgendamento().getCodigo())); 
 	 		
 		}else if(lancamento.getCartaoCredito() != null && ApiUtil.isNotEmpty(lancamento.getCartaoCredito().getCodigo())){
			lancamento.setCartaoCredito(cartaoCreditoService.findById(lancamento.getCartaoCredito().getCodigo()));  
			listParcelaFatura = findParcelasByParametros(lancamento.getCartaoCredito().getCodigo(), lancamento.getDataFatura());
 		}
 		saveLancamento(lancamento, numParcelas); 
 		if(ApiUtil.isNotEmpty(listParcelaFatura)){
 			for(Parcela parcela : listParcelaFatura){
 				saveLancamentoParcela(lancamento.getCodigo(), parcela); 
 			}
 		}
		 
	}
	

	public void saveLancamentoParcela(Integer codLancamento, Parcela parcela) { 
		Lancamento lancamento = lancamentoDao.findOne(parcela.getCodLancamento());
		lancamento.setValor(lancamento.getValor().add(parcela.getValor()));
		lancamentoDao.save(lancamento);
		parcelaDao.saveLancamentoParcela(codLancamento, parcela.getCodigo());
	}

	/************************************************************************************
	 * SAVE LANCAMENTO FATURA 
	 ************************************************************************************/
	private static final int CAT_FATURA = 48;

	@Transactional 
	public void saveLancamentoFatura(Lancamento lancamento) { 
		validarLancamentoFatura(lancamento); 

		lancamento.setCartaoCredito(cartaoCreditoService.findById(lancamento.getCartaoCredito().getCodigo()));  
		List<Parcela> listParcelaFatura = findParcelasByParametros(lancamento.getCartaoCredito().getCodigo(), lancamento.getDataFatura());

		lancamento.setValorPrevisto(BigDecimal.ZERO);
		for(Parcela parcela : listParcelaFatura){
			lancamento.setValorPrevisto(lancamento.getValorPrevisto().add(parcela.getValor()));
		}
		
 		saveLancamento(lancamento, null); // listParcelaFatura=null
 		
		for(Parcela parcela : listParcelaFatura){
			saveLancamentoParcela(lancamento.getCodigo(), parcela); 
		}
	}
	

	private void validarLancamentoFatura(Lancamento lancamento) { 
		validarLancamento(null, lancamento); 

		StringBuilder sb = new StringBuilder();
		if(lancamento.getCartaoCredito() == null || ApiUtil.isEmpty(lancamento.getCartaoCredito().getCodigo())){
			sb.append("O campo \"Cartão de Crédito\" é de preenchimento obrigatório");
 		}else {
 		}
		
		if(ApiUtil.isEmpty(lancamento.getDataFatura())){
			sb.append(", O campo \"Data de Vencimento da Fatura\" é de preenchimento obrigatório");
		}
		
		if(!lancamento.getCategoria().getCodigo().equals(CAT_FATURA)){
			sb.append(", Categoria \""+lancamento.getCategoria().getNome()+"\" não é aceita para pagamento de fatura");
		}

		if(!TipoPagamentoEnum.in(lancamento.getCodTipoPagamento(), TipoPagamentoEnum.A_VISTA)) {
			sb.append(", Forma de pagamento \""+TipoPagamentoEnum.getNome(lancamento.getCodTipoPagamento())+"\" não é aceita para pagamento de fatura");
		}
		

		if(ApiUtil.isNotEmpty(lancamento.getDataFatura()) && lancamento.getCartaoCredito() != null && ApiUtil.isNotEmpty(lancamento.getCartaoCredito().getCodigo())){
			String anoMes = ApiDateUtils.convertDateToString(lancamento.getDataFatura(), "yyyyMM");
 			List<Lancamento> lista = lancamentoDao.findLancamentosFaturas(tokenService.getCodUsuario(), lancamento.getCartaoCredito().getCodigo(), anoMes);
			if(ApiUtil.isNotEmpty(lista)) {
				String dataFatura = ApiDateUtils.convertDateToString(lancamento.getDataFatura(), "dd/MM/yyyy");
				String dataPagamento = ApiDateUtils.convertDateToString(lista.get(0).getDataReferencia(), "dd/MM/yyyy");
				sb.append(", Fatura para a data \""+dataFatura+"\" já foi paga em \""+dataPagamento+"\"");
			}
		}
		
		if (ApiUtil.isNotEmpty(sb.toString())) {
			throw new DadoInconsistenteException(sb.toString());
		}
	}

	/************************************************************************************
	 * FIND PARCELA BY ID
	 ************************************************************************************/
	public Parcela findParcelaById(Integer codParcela){   
		Parcela parcela = parcelaDao.findParcelaById(tokenService.getCodUsuario(), codParcela); 
		if(parcela != null) {
			parcela.setLancamento(lancamentoDao.findById(parcela.getCodLancamento())); 
		}
		return parcela;
	}
	
	/************************************************************************************
	 * FIND PARCELAS PAGAS
	 ************************************************************************************/
	public List<Parcela> findParcelasPagas(String anoMes){   
		List<Parcela> lista = parcelaDao.findParcelasPagas(tokenService.getCodUsuario(), anoMes);
		for(Parcela parcela: lista) { 
			Lancamento lancamento = lancamentoDao.findById(parcela.getCodLancamento());
			if(lancamento != null) {
				parcela.setLancamento(new Lancamento(lancamento.getCodigo()));
				parcela.getLancamento().setDataReferencia(lancamento.getDataReferencia());
				parcela.getLancamento().setCategoria(lancamento.getCategoria());
				parcela.getLancamento().setDataLancamento(null);
			} 
		}
		return lista;
	} 
	
	/************************************************************************************
	 * FIND PARCELAS PENDENTES
	 ************************************************************************************/
	public List<Parcela> findParcelasPendentes(String anoMes){   
		List<Parcela> lista = parcelaDao.findParcelasPendentes(tokenService.getCodUsuario(), anoMes);
		for(Parcela parcela: lista) {
			parcela.setLancamento(lancamentoDao.findById(parcela.getCodLancamento()));
		}
		return lista;
	} 
	
	/************************************************************************************
	 * FIND DATAS PARCELAS PENDENTES
	 ************************************************************************************/
	public List<DataParcelaVO> findDatasParcelasPendentes(){   
		List<DataParcelaVO> list = new ArrayList<DataParcelaVO>();
		for(Object[] obj : parcelaDao.findDatasParcelasPendentes(tokenService.getCodUsuario())){
			list.add(new DataParcelaVO(obj));
		}
    	return list; 
	} 
	
	/************************************************************************************
	 * FIND PARCELAS
	 ************************************************************************************/
	private List<Parcela> findParcelasByLancamento(Lancamento lancamento){   
		List<Parcela> lista = parcelaDao.findByCodLancamento(lancamento.getCodigo());
		for(Parcela parcela: lista) {

			if(TipoPagamentoEnum.in(lancamento.getCodTipoPagamento(), TipoPagamentoEnum.PARCELADO, TipoPagamentoEnum.PARCELADO_CARTAO)) {
				Lancamento lancamentoParcela = null;
				if(TipoPagamentoEnum.in(lancamento.getCodTipoPagamento(), TipoPagamentoEnum.PARCELADO)) {
					lancamentoParcela = lancamentoDao.findByParcela(parcela.getCodigo());
				} 
				if(TipoPagamentoEnum.in(lancamento.getCodTipoPagamento(), TipoPagamentoEnum.PARCELADO_CARTAO)) {
					lancamentoParcela = lancamentoDao.findByParcelaFatura(parcela.getCodigo());
				}
				if(lancamentoParcela != null) {
					parcela.setLancamento(new Lancamento(lancamentoParcela.getCodigo()));
					parcela.getLancamento().setDataReferencia(lancamentoParcela.getDataReferencia());
					parcela.getLancamento().setCategoria(lancamentoParcela.getCategoria());
					parcela.getLancamento().setDataLancamento(null);
					
				}
			}
		}
		return lista;
	} 
	
	/************************************************************************************
	 * FIND PARCELAS BY FATURA
	 ************************************************************************************/
	public List<Parcela> findParcelasByFatura(Integer codLancamento){   
		List<Parcela> lista = parcelaDao.findByFatura(codLancamento);
		for(Parcela parcela: lista) {
			Lancamento lancamento = lancamentoDao.findById(parcela.getCodLancamento());
			if(lancamento != null) {
				parcela.setLancamento(new Lancamento(lancamento.getCodigo()));
				parcela.getLancamento().setDataReferencia(lancamento.getDataReferencia());
				parcela.getLancamento().setCategoria(lancamento.getCategoria());
				parcela.getLancamento().setDataLancamento(null);
				parcela.getLancamento().setDescricao(lancamento.getDescricao());
			} 
		}
		return lista;
	} 

	/************************************************************************************
	 * FIND FATURAS DE CARTAO 
	 ************************************************************************************/
    public List<Lancamento> findFaturas(Integer codCartaoCredito, String anoMes){   
		List<Lancamento> list = lancamentoDao.findLancamentosFaturas(tokenService.getCodUsuario(), codCartaoCredito, anoMes);
		for(Lancamento lancamento : list){ 
			lancamento.setListParcelas(findParcelasByFatura(lancamento.getCodigo()));
		}
    	return list; 
    }

	/************************************************************************************
	 * FIND PARCELAS DE FATURA DE CARTAO 
	 ************************************************************************************/
	public List<Parcela> findParcelasByParametros(Integer codCartaoCredito, Date data){  
		if(ApiUtil.isEmpty(codCartaoCredito)){ 
			throw new DadoInconsistenteException("O ID do cartão de crédito não foi informado");
		}
		if(ApiUtil.isEmpty(data)){ 
			throw new DadoInconsistenteException("A data da fatura do cartão de crédito não foi informado");
		}
		List<Parcela> lista = parcelaDao.findByParameters(tokenService.getCodUsuario(), codCartaoCredito, ApiDateUtils.convertDateToString(data, "dd/MM/yyyy"));

		for(Parcela parcela: lista) {
			parcela.setLancamento(lancamentoDao.findById(parcela.getCodLancamento()));
		}
		return lista;
	} 

	/************************************************************************************
	 * FIND DATAS DAS FATURAS DE CARTAO 
	 ************************************************************************************/
    public List<DataFaturaVO> findDatasFaturas(Integer codCartaoCredito){   
		List<DataFaturaVO> list = new ArrayList<DataFaturaVO>();
		for(Object[] obj : lancamentoDao.findDatasFaturas(tokenService.getCodUsuario(), codCartaoCredito)){
			list.add(new DataFaturaVO(obj));
		}
    	return list; 
    }

	/************************************************************************************
	 * FUNCOES
	 ************************************************************************************/
	private BigDecimal multiplicar(BigDecimal valor, int numero){  
		BigDecimal valor2 = new BigDecimal(numero).setScale(2, RoundingMode.HALF_UP);; 
		return valor.multiply(valor2).setScale(2, RoundingMode.HALF_UP);
	}


	
}
