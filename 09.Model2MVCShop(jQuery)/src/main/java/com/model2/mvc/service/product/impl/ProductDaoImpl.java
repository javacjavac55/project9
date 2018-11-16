package com.model2.mvc.service.product.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductDao;

@Repository("productDaoImpl")
public class ProductDaoImpl implements ProductDao {
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public ProductDaoImpl() {
		
	}
	
	@Override
	public int addProduct(Product product) throws Exception {
		return sqlSession.insert("ProductMapper.addProduct", product);
	}
	
	@Override
	public Product getProduct(int prodNo) throws Exception {
		return sqlSession.selectOne("ProductMapper.getProduct", prodNo);
	}
	
	@Override
	public int updateProduct(Product product) throws Exception {
		return sqlSession.update("ProductMapper.updateProduct", product);
	}
	
	@Override
	public List<Product> getProductList(Search search) throws Exception {
		return sqlSession.selectList("ProductMapper.getProductList", search);
	}

	@Override
	public int getTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("ProductMapper.getTotalCount", search);
	}

	@Override
	public List<Product> getRandomList(int randomSize) throws Exception {
		return sqlSession.selectList("ProductMapper.getRandomList", randomSize);
	}	
	
}
