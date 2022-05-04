package it.unisa.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;



public class Cliente {
	
	private final static String TABLE_NAME="Cliente";
	
	public synchronized void insertUser(UserBean newUser) throws SQLException{
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		try {
			
			String insertSQL = "INSERT INTO "+TABLE_NAME+"(`CF_CLIENTE`, `NOME`, `COGNOME`, `EMAIL`, `PASS`, `CITTA`, `VIA`, `N_CIVICO`, `CAP`, `TIPO`)"+" VALUES ('" + newUser.getCfUtente()
			+ "','" + newUser.getNome() +"','"+ newUser.getCognome() +"','"+ newUser.getEmail()+"','"+ newUser.getPass()+"','"+ newUser.getCitta()+"','"+  newUser.getVia()+"',"+ newUser.getNCivico()+","+ newUser.getCap()+",'"+ 
			newUser.getTipo()+"')";
			connection = DriverManagerConnectionPool.getConnection();
			preparedStatement = connection.prepareStatement(insertSQL);
			System.out.println(newUser.toString());

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
	
	public synchronized boolean deleteUser(String cf) throws SQLException{
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		int rs=0;
		
		String deleteSQL = "DELETE FROM "+TABLE_NAME+" WHERE CF_CLIENTE = ?";
	
		try {
			connection = DriverManagerConnectionPool.getConnection();
			preparedStatement = connection.prepareStatement(deleteSQL);
			preparedStatement.setString(1, cf);
			rs=preparedStatement.executeUpdate();
			connection.commit();		
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				DriverManagerConnectionPool.releaseConnection(connection);
			}
		}
		return (rs!=0);
	}
	
	public synchronized void updateUser(UserBean user) throws SQLException{
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		String updateSQL = "UPDATE "+TABLE_NAME+" SET EMAIL = ?, PASS = ?,  CITTA = ?, VIA = ?, CAP = ?, N_CIVICO = ? WHERE CF_CLIENTE = ?";
		
		try {
			connection = DriverManagerConnectionPool.getConnection();
			preparedStatement = connection.prepareStatement(updateSQL);
			preparedStatement.setString(3, user.getCitta() );
			preparedStatement.setString(4, user.getVia() );
			preparedStatement.setInt(6, user.getNCivico() );
			preparedStatement.setString(1, user.getEmail() );
			preparedStatement.setString(2, user.getPass() );
			preparedStatement.setInt(5, user.getCap());
			preparedStatement.setString(7, user.getCfUtente());
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
	
	public synchronized void updateUserRank(UserBean user) throws SQLException{
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		String updateSQL = "UPDATE "+TABLE_NAME+" SET TIPO = ? WHERE CF_CLIENTE = ?";
		
		try {
			connection = DriverManagerConnectionPool.getConnection();
			preparedStatement = connection.prepareStatement(updateSQL);
			preparedStatement.setString(1, user.getTipo() );
			preparedStatement.setString(2, user.getCfUtente());
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
	
	public synchronized void updateUserPass (UserBean user) throws SQLException{
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		String updateSQL = "UPDATE "+TABLE_NAME+" SET PASS = ? WHERE CF_CLIENTE = ?";
		
		try {
			connection = DriverManagerConnectionPool.getConnection();
			preparedStatement = connection.prepareStatement(updateSQL);
			preparedStatement.setString(1, user.getPass() );
			preparedStatement.setString(2, user.getCfUtente());
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
	
	public synchronized UserBean searchUser(String email) throws SQLException{
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		UserBean user = new UserBean();
		
		String selectSQL = "SELECT * FROM Cliente WHERE EMAIL = ?";
		try {
			connection = DriverManagerConnectionPool.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, email );
			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				user.setCfUtente(rs.getString("CF_CLIENTE"));
				user.setNome(rs.getString("NOME"));
				user.setCognome(rs.getString("COGNOME"));
				user.setEmail(rs.getString("EMAIL"));
				user.setPass(rs.getString("PASS"));
				user.setCitta(rs.getString("CITTA"));
				user.setVia(rs.getString("VIA"));
				user.setCap(rs.getInt("CAP"));
				user.setNCivico(rs.getInt("N_CIVICO"));
				user.setRank(rs.getString("TIPO"));

			}

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				DriverManagerConnectionPool.releaseConnection(connection);
			}
		}
		
		
		return user;
	}
	
	public synchronized UserBean searchUserByCF(String cf) throws SQLException{

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		UserBean user = new UserBean();
		
		String selectSQL = "SELECT * FROM Cliente WHERE CF_CLIENTE = ?";
		try {
			connection = DriverManagerConnectionPool.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, cf);
			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				user.setCfUtente(rs.getString("CF_CLIENTE"));
				user.setNome(rs.getString("NOME"));
				user.setCognome(rs.getString("COGNOME"));
				user.setEmail(rs.getString("EMAIL"));
				user.setPass(rs.getString("PASS"));
				user.setCitta(rs.getString("CITTA"));
				user.setVia(rs.getString("VIA"));
				user.setCap(rs.getInt("CAP"));
				user.setNCivico(rs.getInt("N_CIVICO"));
				user.setRank(rs.getString("TIPO"));

			}

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				DriverManagerConnectionPool.releaseConnection(connection);
			}
		}
		
		
		return user;
	}
	
	public Collection<UserBean> getUsers(int numberPage)throws SQLException{
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		UserBean user;
		Collection<UserBean> allUser = new LinkedList<UserBean>();
		 
		String selectSQL = "SELECT * FROM Cliente ";
		selectSQL+="LIMIT "+ (6) +" OFFSET "+ ((numberPage*6)-6);
		
		try {
			connection = DriverManagerConnectionPool.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				user= new UserBean();
				user.setCfUtente(rs.getString("CF_CLIENTE"));
				user.setNome(rs.getString("NOME"));
				user.setCognome(rs.getString("COGNOME"));
				user.setEmail(rs.getString("EMAIL"));
				user.setPass(rs.getString("PASS"));
				user.setCitta(rs.getString("CITTA"));
				user.setVia(rs.getString("VIA"));
				user.setCap(rs.getInt("CAP"));
				user.setNCivico(rs.getInt("N_CIVICO"));
				user.setRank(rs.getString("TIPO"));
				allUser.add(user);
			}

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				DriverManagerConnectionPool.releaseConnection(connection);
			}
		}
		
		
		return allUser;
	}
	
	public Collection<UserBean> getUsers()throws SQLException{
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		UserBean user;
		Collection<UserBean> allUser = new LinkedList<UserBean>();
		 
		String selectSQL = "SELECT * FROM Cliente ";
		
		try {
			connection = DriverManagerConnectionPool.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				user= new UserBean();
				user.setCfUtente(rs.getString("CF_CLIENTE"));
				user.setNome(rs.getString("NOME"));
				user.setCognome(rs.getString("COGNOME"));
				user.setEmail(rs.getString("EMAIL"));
				user.setPass(rs.getString("PASS"));
				user.setCitta(rs.getString("CITTA"));
				user.setVia(rs.getString("VIA"));
				user.setCap(rs.getInt("CAP"));
				user.setNCivico(rs.getInt("N_CIVICO"));
				user.setRank(rs.getString("TIPO"));
				allUser.add(user);
			}

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				DriverManagerConnectionPool.releaseConnection(connection);
			}
		}
		
		
		return allUser;
	}
}
