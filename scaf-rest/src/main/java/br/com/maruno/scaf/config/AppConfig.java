package br.com.maruno.scaf.config;

import javax.sql.DataSource;

import org.springframework.cache.CacheManager;
import org.springframework.cache.concurrent.ConcurrentMapCacheManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.orm.hibernate4.HibernateExceptionTranslator;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.transaction.PlatformTransactionManager;

import br.com.maruno.api.annotation.ApiConfiguration;
import br.com.maruno.api.config.ApiEntityManager;

/**
 * @Aplicativo 
 * @Modulo scaf-rest
 * @Autor <a href="mailto:jackmaruno@gmail.com">Willian.Maruno</a>
 * @Data Jan 26, 2019 8:22:26 PM
 * @Pacote br.com.maruno.scaf.config
 * @Nome AppConfig.java
 * @NomeCompleto br.com.maruno.scaf.config.AppConfig.java
 */
@ApiConfiguration(component="br.com.maruno.scaf", persistence="br.com.maruno.scaf.persistence")
public class AppConfig  {
	
	private ApiEntityManager em = new ApiEntityManager("quaemo-scaf")
			                          .dialect(ApiEntityManager.MYSQL)
                                      .dataSource("java:jboss/datasources/Quaemo_ScafDS")
                                      .packagesToScan(new String[] { "br.com.maruno.scaf.domain"}) 
                                      .showSql()
                                      ;
	
	@Bean
	public static PropertySourcesPlaceholderConfigurer placeHolderConfigurer(){
		return new PropertySourcesPlaceholderConfigurer();
	}

	@Bean
	public PlatformTransactionManager transactionManager(){
		return new JpaTransactionManager(entityManagerFactory().getObject());
	}

	@Bean
	public LocalContainerEntityManagerFactoryBean entityManagerFactory(){
		return em.getEntityManagerFactory(); 
	}

	@Bean
	public HibernateExceptionTranslator hibernateExceptionTranslator(){
		return new HibernateExceptionTranslator();
	}

	@Bean(name = "dataSource")
	public DataSource dataSource() { 
		return em.getDataSource();
	} 

	@Bean
	public CacheManager cacheManager(){
		return new ConcurrentMapCacheManager();
	} 
}
