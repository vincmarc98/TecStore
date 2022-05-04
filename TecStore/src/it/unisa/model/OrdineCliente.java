package it.unisa.model;

import java.sql.*;
import java.util.*;

public class OrdineCliente {

	private final static String TABLE_NAME="Ordine";

	public synchronized void insertNewOrder(OrderBean order,UserBean user) throws SQLException{
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String insertSql = "INSERT INTO "+
				TABLE_NAME+" (CODICE_ORDINE, DATAORDINE, MEZZO, N_MERCI, "
				+ "TOTALE, METODODIPAGAMENTO, N_CARTA, CF_CLIENTE,CITTA,VIA,N_CIVICO,CAP, STATO)"
				+" VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)";

		try {
			connection = DriverManagerConnectionPool.getConnection();
			preparedStatement = connection.prepareStatement(insertSql);
			preparedStatement.setInt(1,order.getCodiceOrdine());
			preparedStatement.setString(2,order.getDataOrdine());
			preparedStatement.setString(3,order.getMezzo());
			preparedStatement.setInt(4,order.getnMerci());
			preparedStatement.setDouble(5,order.getTotale());
			preparedStatement.setString(6,order.getMetodoDiPagamento());
			preparedStatement.setString(7,order.getNumCard());
			preparedStatement.setString(8, order.getCfCliente());
			preparedStatement.setString(9, user.getCitta());
			preparedStatement.setString(10, user.getVia());
			preparedStatement.setInt(11, user.getNCivico());
			preparedStatement.setInt(12, user.getCap());
			preparedStatement.setString(13, "Processing");	
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

	public synchronized boolean deleteOrder(int codiceOrdine)throws SQLException{
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		int result=0;

		String deleteSql = "UPDATE "+TABLE_NAME+" SET STATO=? WHERE CODICE_ORDINE=?";
		try{
			connection=DriverManagerConnectionPool.getConnection();
			preparedStatement=connection.prepareStatement(deleteSql);
			preparedStatement.setString(1, "Canceled");
			preparedStatement.setInt(2, codiceOrdine);
			result=preparedStatement.executeUpdate();
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

		return (result!=0);
	}

	public synchronized OrderBean searchByCodeOrder(int codiceOrdine)throws SQLException{
		Connection connection=null;
		PreparedStatement preparedStatement=null;
		ResultSet result=null;
		OrderBean order=new OrderBean();
		String searchSqlCodeOrder="SELECT * FROM "+TABLE_NAME+" WHERE CODICE_ORDINE=?";
		try{
			connection=DriverManagerConnectionPool.getConnection();
			preparedStatement=connection.prepareStatement(searchSqlCodeOrder);
			preparedStatement.setInt(1, codiceOrdine);

			result=preparedStatement.executeQuery();

			while(result.next()){
				order.setCodiceOrdine(result.getInt("CODICE_ORDINE"));
				order.setDataOrdine(result.getString("DATAORDINE"));
				order.setMezzo(result.getString("MEZZO"));
				order.setnMerci(result.getInt("N_MERCI"));
				order.setTotale(result.getDouble("TOTALE"));
				order.setMetodoDiPagamento(result.getString("METODODIPAGAMENTO"));
				order.setNumCard(result.getString("N_CARTA"));
				order.setCfCliente(result.getString("CF_CLIENTE"));
				order.setCitta(result.getString("CITTA"));
				order.setVia(result.getString("VIA"));
				order.setCivico(result.getInt("N_CIVICO"));
				order.setCap(result.getInt("CAP"));
				order.setStato(result.getString("STATO"));

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

		return order;

	}

	public synchronized  Collection<OrderBean> searchByCFUser(String codiceCfCliente)throws SQLException{
		Connection connection=null;
		PreparedStatement preparedStatement=null;
		ResultSet result=null;
		OrderBean order;

		Collection<OrderBean> ordersList = new LinkedList<OrderBean>();

		String searchSqlCodeUser="SELECT * FROM "+TABLE_NAME+" WHERE CF_CLIENTE=? ORDER BY CODICE_ORDINE";

		try{
			connection=DriverManagerConnectionPool.getConnection();
			preparedStatement= connection.prepareStatement(searchSqlCodeUser);
			preparedStatement.setString(1,codiceCfCliente);

			result=preparedStatement.executeQuery();

			while(result.next()){
				order= new OrderBean();
				order.setCodiceOrdine(result.getInt("CODICE_ORDINE"));
				order.setDataOrdine(result.getString("DATAORDINE"));
				order.setMezzo(result.getString("MEZZO"));
				order.setnMerci(result.getInt("N_MERCI"));
				order.setTotale(result.getDouble("TOTALE"));
				order.setMetodoDiPagamento(result.getString("METODODIPAGAMENTO"));
				order.setNumCard(result.getString("N_CARTA"));
				order.setCfCliente(result.getString("CF_CLIENTE"));
				order.setCitta(result.getString("CITTA"));
				order.setVia(result.getString("VIA"));
				order.setCivico(result.getInt("N_CIVICO"));
				order.setCap(result.getInt("CAP"));
				order.setStato(result.getString("STATO"));
				ordersList.add(order);
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

		return ordersList;
	}

	public synchronized Collection<OrderBean> getAllOrders(int numberPage) throws SQLException {

		Connection connection=null;
		PreparedStatement preparedStatement=null;
		ResultSet result=null;
		OrderBean order;

		Collection<OrderBean> ordersList = new LinkedList<OrderBean>();

		String sqlGetAllOrders="SELECT * FROM "+TABLE_NAME +" ORDER BY CODICE_ORDINE";
		sqlGetAllOrders+=" LIMIT "+ (4) +" OFFSET "+ ((numberPage*4)-4);
		try{
			connection=DriverManagerConnectionPool.getConnection();
			preparedStatement= connection.prepareStatement(sqlGetAllOrders);

			result=preparedStatement.executeQuery();

			while(result.next()){
				order=new OrderBean();
				order.setCodiceOrdine(result.getInt("CODICE_ORDINE"));
				order.setDataOrdine(result.getString("DATAORDINE"));
				order.setMezzo(result.getString("MEZZO"));
				order.setnMerci(result.getInt("N_MERCI"));
				order.setTotale(result.getDouble("TOTALE"));
				order.setMetodoDiPagamento(result.getString("METODODIPAGAMENTO"));
				order.setNumCard(result.getString("N_CARTA"));
				order.setCfCliente(result.getString("CF_CLIENTE"));
				order.setCitta(result.getString("CITTA"));
				order.setVia(result.getString("VIA"));
				order.setCivico(result.getInt("N_CIVICO"));
				order.setCap(result.getInt("CAP"));
				order.setStato(result.getString("STATO"));
				ordersList.add(order);
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

		return ordersList;
	}

	public void updateOrderState(OrderBean order) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		String updateSQL = "UPDATE "+ TABLE_NAME +" SET STATO = ? WHERE CODICE_ORDINE = ?";
		
		try {
			connection = DriverManagerConnectionPool.getConnection();
			preparedStatement = connection.prepareStatement(updateSQL);
			preparedStatement.setString(1, order.getStato() );
			preparedStatement.setInt(2, order.getCodiceOrdine());
			preparedStatement.executeUpdate();
			connection.commit();
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				DriverManagerConnectionPool.releaseConnection(connection);
			}
		}
		
	}

	
	
	
}
