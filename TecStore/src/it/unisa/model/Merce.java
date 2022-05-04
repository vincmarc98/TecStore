package it.unisa.model;

import java.sql.*;

import java.util.*;

public class Merce {

	private final static String TABLE_NAME="Merce";
	
		public synchronized void insertNewMerce(MerceBean merce)throws SQLException{
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			
			String sqlInsert="INSERT INTO "+TABLE_NAME+"(CODICE_MERCE, TITOLO, CATEGORIA, DESCRIZIONE, COSTO, IMMAGINE)VALUES(?,?,?,?,?,?)";
			try{
				connection = DriverManagerConnectionPool.getConnection();
				preparedStatement=connection.prepareStatement(sqlInsert);
				preparedStatement.setInt(1, merce.getCodiceMerce());
				preparedStatement.setString(2, merce.getTitolo());
				preparedStatement.setString(3, merce.getCategoria());
				preparedStatement.setString(4, merce.getDescrizione());
				preparedStatement.setDouble(5, merce.getCosto());
				preparedStatement.setBytes(6, merce.getImmagine());
				
				preparedStatement.executeUpdate();
				
				connection.commit();
			} finally {
				try{
					if(connection!=null){
						connection.close();
					}
				} finally {
					DriverManagerConnectionPool.releaseConnection(connection);
				}
			}
		}
		
		public synchronized boolean deleteMerce(String codiceMerce)throws SQLException{
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			int rs=0;
			
			String deleteSQL="DELETE FROM "+TABLE_NAME+" WHERE CODICE_MERCE=?";
			
			try{
				connection = DriverManagerConnectionPool.getConnection();
				preparedStatement=connection.prepareStatement(deleteSQL);
				preparedStatement.setString(1, codiceMerce);
				rs=preparedStatement.executeUpdate();
				connection.commit();
			} finally {
				try{
					if(connection!=null){
						connection.close();
					}
				} finally {
					DriverManagerConnectionPool.releaseConnection(connection);
				}
				
			}
			
			return (rs!=0);
		}
		
		public synchronized void updateMerce(MerceBean merce)throws SQLException{
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			String updateSQL="UPDATE "+TABLE_NAME+" SET TITOLO=?, CATEGORIA=?, DESCRIZIONE=?, COSTO=?, IMMAGINE=? WHERE CODICE_MERCE=?";
			try{
				connection=DriverManagerConnectionPool.getConnection();
				preparedStatement=connection.prepareStatement(updateSQL);
				preparedStatement.setString(1, merce.getTitolo());
				preparedStatement.setString(2, merce.getCategoria());
				preparedStatement.setString(3, merce.getDescrizione());
				preparedStatement.setDouble(4, merce.getCosto());
				preparedStatement.setBytes(5, merce.getImmagine());
				preparedStatement.setInt(6, merce.getCodiceMerce());
				preparedStatement.executeUpdate();
				connection.commit();
			} finally {
				
				try{
					if(connection!=null){
						connection.close();
					}
				} finally {
					DriverManagerConnectionPool.releaseConnection(connection);
				}
			}
			
		}
		
		public synchronized MerceBean searchMerceByCodiceMerce(String codiceMerce)throws SQLException{
			MerceBean merce = new MerceBean();
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			ResultSet rs = null;
			String searchMerceSql = "SELECT * FROM "+TABLE_NAME+ " WHERE CODICE_MERCE = ? ";
			
			
			try{
				connection = DriverManagerConnectionPool.getConnection();
				preparedStatement = connection.prepareStatement(searchMerceSql);
				preparedStatement.setString(1, codiceMerce);
				rs = preparedStatement.executeQuery();
				
				
				
				if(rs.next()){
					merce.setCodiceMerce(rs.getInt("CODICE_MERCE"));
					merce.setTitolo(rs.getString("TITOLO"));
					merce.setCategoria(rs.getString("CATEGORIA"));
					merce.setDescrizione(rs.getString("DESCRIZIONE"));
					merce.setCosto(rs.getDouble("COSTO"));
					merce.setImmagine(rs.getBytes("IMMAGINE"));
				}
			
			} finally {
				try{
					if(connection!=null){
						connection.close();
					}
				} finally {
					DriverManagerConnectionPool.releaseConnection(connection);
				}
				
			}
			
			return merce;
		}
		
		public synchronized Collection<MerceBean> searchMerceByCategoria (String codice,int numberPage)throws SQLException{
			
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			ResultSet rs=null;
			String searchMerceSql="SELECT * FROM "+TABLE_NAME + " WHERE CATEGORIA=?";
			searchMerceSql+=" LIMIT "+ (6) +" OFFSET "+ ((numberPage*6)-6);
			Collection<MerceBean> merceList= new LinkedList<MerceBean>();
			MerceBean merce;
			
			
			try{
				connection=DriverManagerConnectionPool.getConnection();
				preparedStatement=connection.prepareStatement(searchMerceSql);
				preparedStatement.setString(1, codice);
					
				rs=preparedStatement.executeQuery();
				
				while(rs.next()){
					merce = new MerceBean();
					merce.setCodiceMerce(rs.getInt("CODICE_MERCE"));
					merce.setCategoria(rs.getString("CATEGORIA"));
					merce.setTitolo(rs.getString("TITOLO"));
					merce.setDescrizione(rs.getString("DESCRIZIONE"));
					merce.setCosto(rs.getDouble("COSTO"));
					merce.setImmagine(rs.getBytes("IMMAGINE"));
					merceList.add(merce);
				}


			} finally{
				try{
					if(connection!=null){
						connection.close();
					}
				} finally {
					DriverManagerConnectionPool.releaseConnection(connection);
				}
			}
			
			
			return merceList;
		}
		
		public synchronized Collection<MerceBean> getAllMerce(String order,int numberPage)throws SQLException{
			
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			Collection<MerceBean> merceList = new LinkedList<MerceBean>();
			MerceBean merce;
			
			
			ResultSet rs=null;
			String getAllMerceSql="SELECT * FROM "+TABLE_NAME;
			
			if(order!=null){
				getAllMerceSql+="ORDER BY "+order;
			}
			
			
			getAllMerceSql+=" LIMIT "+ (6) +" OFFSET "+ ((numberPage*6)-6);
			
			
			try{
				connection=DriverManagerConnectionPool.getConnection();
				preparedStatement = connection.prepareStatement(getAllMerceSql);
			
				rs=preparedStatement.executeQuery();

				while(rs.next()){
					merce = new MerceBean();
					merce.setCodiceMerce(rs.getInt("CODICE_MERCE"));
					merce.setTitolo(rs.getString("TITOLO"));
					merce.setCategoria(rs.getString("CATEGORIA"));
					merce.setDescrizione(rs.getString("DESCRIZIONE"));
					merce.setCosto(rs.getDouble("COSTO"));
					merce.setImmagine(rs.getBytes("IMMAGINE"));
					merceList.add(merce);
				}


			} finally {
				try {
					if (preparedStatement != null)
						preparedStatement.close();
				} finally {
					DriverManagerConnectionPool.releaseConnection(connection);
				}

			}
			return merceList;
		}

		public synchronized Collection<MerceBean> searchMerceByTitolo(String titolo, int numberPage)throws SQLException{
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			MerceBean merce;
			Collection<MerceBean> merceList = new LinkedList<MerceBean>();
			
			String selectSQL = "SELECT * FROM "+TABLE_NAME+" WHERE TITOLO LIKE ? ORDER BY CODICE_MERCE";
			selectSQL+=" LIMIT "+ (6) +" OFFSET "+ ((numberPage*6)-6);
			
			try {
				connection = DriverManagerConnectionPool.getConnection();
				preparedStatement = connection.prepareStatement(selectSQL);
				preparedStatement.setString(1, "%"+titolo+"%" );
				ResultSet rs = preparedStatement.executeQuery();

				while (rs.next()) {
					merce = new MerceBean();
					merce.setCodiceMerce(rs.getInt("CODICE_MERCE"));
					merce.setTitolo(rs.getString("TITOLO"));
					merce.setCategoria(rs.getString("CATEGORIA"));
					merce.setDescrizione(rs.getString("DESCRIZIONE"));
					merce.setCosto(rs.getDouble("COSTO"));
					merce.setImmagine(rs.getBytes("IMMAGINE"));
					merceList.add(merce);
				}

			} finally {
				try {
					if (preparedStatement != null)
						preparedStatement.close();
				} finally {
					DriverManagerConnectionPool.releaseConnection(connection);
				}
			}
		
			return merceList;
		}
	
}
