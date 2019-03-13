package br.com.maruno.scaf.config;

import javax.servlet.Filter;

import org.springframework.orm.jpa.support.OpenEntityManagerInViewFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

import br.com.maruno.api.config.ApiWebMvcConfigAdapter;

  
/**
 * @Aplicativo 
 * @Modulo scaf-rest
 * @Autor <a href="mailto:jackmaruno@gmail.com">Willian.Maruno</a>
 * @Data Jan 26, 2019 8:22:16 PM
 * @Pacote br.com.maruno.scaf.config
 * @Nome SpringWebAppInitializer.java
 * @NomeCompleto br.com.maruno.scaf.config.SpringWebAppInitializer.java
 */
public class SpringWebAppInitializer extends AbstractAnnotationConfigDispatcherServletInitializer{

	@Override
	protected Class<?>[] getRootConfigClasses(){
		return new Class<?>[] {AppConfig.class};
	}

	@Override
	protected Class<?>[] getServletConfigClasses(){
		return new Class<?>[] {WebMvcConfig.class, ApiWebMvcConfigAdapter.class};
	}

	@Override
	protected String[] getServletMappings(){
		return new String[] { "/*" };
	}
	
	@Override
    protected Filter[] getServletFilters() {
       return new Filter[]{new OpenEntityManagerInViewFilter()};
    } 

}
