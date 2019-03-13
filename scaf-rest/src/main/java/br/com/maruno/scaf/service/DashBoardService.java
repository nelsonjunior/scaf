/*
 * Direitos Autorais 2018 Willian Ferreira Maruno
 * 
 * Este sistema e confidencial e de propriedade do desenvolvedor Willian Ferreira Maruno.
 * A divulgacao das informacoes contidas aqui somente serao aceitas
 * mediante acordo previo estabelecido para com o desenvolvedor.
 */
package br.com.maruno.scaf.service;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.maruno.api.service.TokenService;
import br.com.maruno.api.support.ApiDateUtils;
import br.com.maruno.scaf.persistence.DashBoardDao;

/**
 * @Aplicativo 
 * @Modulo scaf-rest
 * @Autor <a href="mailto:jackmaruno@gmail.com">Willian.Maruno</a>
 * @Data Mar 6, 2019 5:05:30 PM
 * @Pacote br.com.maruno.scaf.service
 * @Nome DashBoardService.java
 * @NomeCompleto br.com.maruno.scaf.service.DashBoardService.java
 */
@Service
public class DashBoardService {

	@Autowired
	private TokenService tokenService;
	
	@Autowired
	private DashBoardDao dashBoardDao;
	

	private static final String ULTIMAS_ATIVIDADES = "ultimasAtividades";
	private static final String PROXIMAS_ATIVIDADES = "proximasAtividades";
	private static final String ATIVIDADES_MES = "atividadesMes";
	private static final String ATIVIDADES_12_MESES = "atividades12Meses";
	private static final String AGENDA = "agenda";
	
	public Map<String, List<Object[]>> findDashBoard(){
		Integer codUsuario = tokenService.getCodUsuario();
		Map<String, List<Object[]>> mapa = new TreeMap<String, List<Object[]>>();
		
		mapa.put(ULTIMAS_ATIVIDADES, converter(dashBoardDao.findUltimasAtividades(codUsuario, ApiDateUtils.convertDateToString(new Date(), "yyyyMM"))));
		mapa.put(PROXIMAS_ATIVIDADES, converter(dashBoardDao.findProximasAtividades(codUsuario)));
//		mapa.put(ATIVIDADES_MES, converter(dashBoardDao.findResumoMes(codUsuario)));
//		mapa.put(ATIVIDADES_12_MESES, converter(dashBoardDao.findDespesasReceitas(codUsuario))); //12 meses
//		mapa.put(AGENDA, converter(dashBoardDao.findAgendaAtual(codUsuario)));
		
		
		return mapa;
	}
 
	

	private List<Object[]> converter(List<Object[]> list){
//		List<Lancamento> lista = new ArrayList<Lancamento>();
//		for(Object[] o: list){
//			lista.add(new DashBoardDTO(o, tipo));
//		}
		return list;
	}
 

	public List<Object[]> findRelacaoLancamentos(Integer codTipo){
		return dashBoardDao.findRelacaoLancamentos(tokenService.getCodUsuario(), ApiDateUtils.convertDateToString(new Date(), "yyyyMM"), codTipo); 
	}
	
}
