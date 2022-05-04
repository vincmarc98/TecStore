package it.unisa.model;

import java.sql.*;

import java.util.*;

public class Ticket {

	private final static String TABLE_NAME="Ticket";
	
		public synchronized void insertNewticket(TicketBean ticket)throws SQLException{
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			
			String sqlInsert="INSERT INTO "+TABLE_NAME+"(CODICE_TICKET,TITOLO,DESCRIZIONE,STATO,CODICE_ORDINE,CF_CLIENTE) VALUES(?,?,?,?,?,?)";
			try{
				connection = DriverManagerConnectionPool.getConnection();
				preparedStatement=connection.prepareStatement(sqlInsert);
				preparedStatement.setInt(1, ticket.getCodiceTicket());
				preparedStatement.setString(2, ticket.getTitolo());
				preparedStatement.setString(3, ticket.getDescrizione());
				preparedStatement.setString(4, ticket.getStato());
				preparedStatement.setInt(5, ticket.getCodiceOrdine());
				preparedStatement.setString(6, ticket.getCodiceFiscale());
			
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
		
		public synchronized boolean closeTicket(int codiceticket)throws SQLException{
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			int rs=0;
			
			String deleteSQL="UPDATE "+TABLE_NAME+" SET STATO=? WHERE CODICE_TICKET=?";
			
			try{
				connection = DriverManagerConnectionPool.getConnection();
				preparedStatement=connection.prepareStatement(deleteSQL);
				preparedStatement.setInt(2, codiceticket);
				preparedStatement.setString(1, "Chiuso");
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
		
		public synchronized TicketBean searchTicketByCodiceTicket(int codiceticket)throws SQLException{
			TicketBean ticket = new TicketBean();
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			ResultSet rs = null;
			String searchticketSql = "SELECT * FROM "+TABLE_NAME+ " WHERE CODICE_TICKET = ? ";
			
			
			try{
				connection = DriverManagerConnectionPool.getConnection();
				preparedStatement = connection.prepareStatement(searchticketSql);
				preparedStatement.setInt(1, codiceticket);
				rs = preparedStatement.executeQuery();
				
				
				
				if(rs.next()){
					ticket.setCodiceTicket(rs.getInt("CODICE_TICKET"));
					ticket.setTitolo(rs.getString("TITOLO"));
					ticket.setDescrizione(rs.getString("DESCRIZIONE"));
					ticket.setStato(rs.getString("STATO"));
					ticket.setCodiceOrdine(rs.getInt("CODICE_ORDINE"));
					ticket.setCodiceFiscale(rs.getString("CF_CLIENTE"));
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
			
			return ticket;
		}
		
		public synchronized Collection<TicketBean> searchOpenTicketsByCf (String cf,int numberPage)throws SQLException{
			
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			ResultSet rs=null;
			String searchticketSql="SELECT * FROM "+TABLE_NAME + " WHERE CF_CLIENTE=? AND STATO=?";
			searchticketSql+=" LIMIT "+ (6) +" OFFSET "+ ((numberPage*6)-6);
			Collection<TicketBean> ticketList= new LinkedList<TicketBean>();
			TicketBean ticket;
			
			
			try{
				connection=DriverManagerConnectionPool.getConnection();
				preparedStatement=connection.prepareStatement(searchticketSql);
				preparedStatement.setString(1, cf);
				preparedStatement.setString(2, "Aperto");
					
				rs=preparedStatement.executeQuery();
				
				while(rs.next()){
					ticket = new TicketBean();
					ticket.setCodiceTicket(rs.getInt("CODICE_TICKET"));
					ticket.setTitolo(rs.getString("TITOLO"));
					ticket.setDescrizione(rs.getString("DESCRIZIONE"));
					ticket.setStato(rs.getString("STATO"));
					ticket.setCodiceOrdine(rs.getInt("CODICE_ORDINE"));
					ticket.setCodiceFiscale(rs.getString("CF_CLIENTE"));
					ticketList.add(ticket);
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
			
			
			return ticketList;
		}
			
        public synchronized Collection<TicketBean> searchClosedTicketsByCf (String cf,int numberPage)throws SQLException{
			
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			ResultSet rs=null;
			String searchticketSql="SELECT * FROM "+TABLE_NAME + " WHERE CF_CLIENTE=? AND STATO=?";
			searchticketSql+=" LIMIT "+ (6) +" OFFSET "+ ((numberPage*6)-6);
			Collection<TicketBean> ticketList= new LinkedList<TicketBean>();
			TicketBean ticket;
			
			
			try{
				connection=DriverManagerConnectionPool.getConnection();
				preparedStatement=connection.prepareStatement(searchticketSql);
				preparedStatement.setString(1, cf);
				preparedStatement.setString(2, "Chiuso");
					
				rs=preparedStatement.executeQuery();
				
				while(rs.next()){
					ticket = new TicketBean();
					ticket.setCodiceTicket(rs.getInt("CODICE_TICKET"));
					ticket.setTitolo(rs.getString("TITOLO"));
					ticket.setDescrizione(rs.getString("DESCRIZIONE"));
					ticket.setStato(rs.getString("STATO"));
					ticket.setCodiceOrdine(rs.getInt("CODICE_ORDINE"));
					ticket.setCodiceFiscale(rs.getString("CF_CLIENTE"));
					ticketList.add(ticket);
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
			
			
			return ticketList;
		}
		
		public synchronized Collection<TicketBean> getAllTickets(int numberPage)throws SQLException{
			
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			Collection<TicketBean> ticketList = new LinkedList<TicketBean>();
			TicketBean ticket;
			
			ResultSet rs=null;
			String getAllticketSql="SELECT * FROM "+TABLE_NAME;
			
			getAllticketSql+=" LIMIT "+ (6) +" OFFSET "+ ((numberPage*6)-6);
			
			
			try{
				connection=DriverManagerConnectionPool.getConnection();
				preparedStatement = connection.prepareStatement(getAllticketSql);
			
				rs=preparedStatement.executeQuery();

				while(rs.next()){
					ticket = new TicketBean();
					ticket.setCodiceTicket(rs.getInt("CODICE_TICKET"));
					ticket.setTitolo(rs.getString("TITOLO"));
					ticket.setDescrizione(rs.getString("DESCRIZIONE"));
					ticket.setStato(rs.getString("STATO"));
					ticket.setCodiceOrdine(rs.getInt("CODICE_ORDINE"));
					ticket.setCodiceFiscale(rs.getString("CF_CLIENTE"));
					ticketList.add(ticket);
				}


			} finally {
				try {
					if (preparedStatement != null)
						preparedStatement.close();
				} finally {
					DriverManagerConnectionPool.releaseConnection(connection);
				}

			}
			return ticketList;
		}
			
        public synchronized Collection<TicketBean> searchTicketsByCf (String cf,int numberPage)throws SQLException{
			
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			ResultSet rs=null;
			String searchticketSql="SELECT * FROM "+TABLE_NAME + " WHERE CF_CLIENTE=?";
			searchticketSql+=" LIMIT "+ (6) +" OFFSET "+ ((numberPage*6)-6);
			Collection<TicketBean> ticketList= new LinkedList<TicketBean>();
			TicketBean ticket;
			
			
			try{
				connection=DriverManagerConnectionPool.getConnection();
				preparedStatement=connection.prepareStatement(searchticketSql);
				preparedStatement.setString(1, cf);
					
				rs=preparedStatement.executeQuery();
				
				while(rs.next()){
					ticket = new TicketBean();
					ticket.setCodiceTicket(rs.getInt("CODICE_TICKET"));
					ticket.setTitolo(rs.getString("TITOLO"));
					ticket.setDescrizione(rs.getString("DESCRIZIONE"));
					ticket.setStato(rs.getString("STATO"));
					ticket.setCodiceOrdine(rs.getInt("CODICE_ORDINE"));
					ticket.setCodiceFiscale(rs.getString("CF_CLIENTE"));
					ticketList.add(ticket);
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
			
			return ticketList;
		}
         
        public void updateTicketState(TicketBean ticket) throws SQLException {
	   		Connection connection = null;
	   		PreparedStatement preparedStatement = null;
	   		
	   		String updateSQL = "UPDATE "+ TABLE_NAME +" SET STATO = ? WHERE CODICE_TICKET = ?";
	   		
	   		try {
	   			connection = DriverManagerConnectionPool.getConnection();
	   			preparedStatement = connection.prepareStatement(updateSQL);
	   			preparedStatement.setString(1, ticket.getStato() );
	   			preparedStatement.setInt(2, ticket.getCodiceTicket());
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
