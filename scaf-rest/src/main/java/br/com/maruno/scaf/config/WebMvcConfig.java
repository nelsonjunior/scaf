package br.com.maruno.scaf.config;

import org.springframework.context.annotation.Bean;
import org.springframework.data.rest.core.config.RepositoryRestConfiguration;
import org.springframework.data.rest.webmvc.config.RepositoryRestConfigurer;
import org.springframework.data.rest.webmvc.config.RepositoryRestConfigurerAdapter;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import br.com.maruno.api.annotation.ApiWebMvcConfiguration;
import br.com.maruno.api.config.ApiWebMvcConfigAdapter;
   
/**
 * @Aplicativo 
 * @Modulo scaf-rest
 * @Autor <a href="mailto:jackmaruno@gmail.com">Willian.Maruno</a>
 * @Data Jan 26, 2019 8:22:22 PM
 * @Pacote br.com.maruno.scaf.config
 * @Nome WebMvcConfig.java
 * @NomeCompleto br.com.maruno.scaf.config.WebMvcConfig.java
 */
@ApiWebMvcConfiguration("br.com.maruno.scaf")
public class WebMvcConfig extends ApiWebMvcConfigAdapter{

	@Override
	public void addViewControllers(ViewControllerRegistry registry){
		super.addViewControllers(registry);
		registry.addViewController("login").setViewName("login");
		registry.addViewController("home").setViewName("home");
	}

	@Bean
	public ViewResolver resolver(){
		InternalResourceViewResolver url = new InternalResourceViewResolver();
		url.setPrefix("/view/");
		url.setSuffix(".html");
		return url;
	}

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry){
		registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
	}

	@Bean
	public RepositoryRestConfigurer repositoryRestConfigurer() {
		System.out.println("repositoryRestConfigurer"); 
		return new RepositoryRestConfigurerAdapter() {
			@Override
			public void configureRepositoryRestConfiguration(RepositoryRestConfiguration config) {
				System.out.println("configureRepositoryRestConfiguration " + config); 
				config.setBasePath("/KCT-buceta/api/");
			}
		};
	}
	
	@Bean(name = "codSistema")
	public Integer codSistema()	{	   
		return 4;
	}

	@Bean
	public ScafFilter scafInterceptor() {
		return new ScafFilter();
	}
 
	
}
