/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataProvider;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author HT
 */
public class ConnectionManager {
    
   private static ConnectionManager instance;
    private static Connection conn = null;
    private final String JDBC_DRIVER = "oracle.jdbc.driver.OracleDriver";
    
    private ConnectionManager() { }

    /**
     * @return the instance
     */
    public static ConnectionManager getInstance() {
        if (instance == null)
            instance = new ConnectionManager();
        
        return instance;
    }
    
    public Connection getConnection()
    {
        try 
        {
            Class.forName(JDBC_DRIVER);
            
            if (conn == null) 
            {
                conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "cafe", "cafe");
                conn.setAutoCommit(false);
            }
            
            System.out.println("Connected!!!");
        } 
        catch (SQLException | ClassNotFoundException e) 
        {
            System.out.println("Disconnected!!!");
        }      
        return conn;
    }
    
    public ResultSet executeQuery(String query, String[] parametter )
    {
        //Connection connect = 
        this.getConnection();
        ResultSet rs = null;
        try 
        {
            PreparedStatement pstat = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            
            if (parametter != null)
            {
                for (int i = 0; i < parametter.length; i++)
                {
                    pstat.setString(i + 1, parametter[i]);
                }
            }
            
            rs = pstat.executeQuery();
            conn.commit();
        } 
        catch (SQLException ex) 
        {
            Logger.getLogger(ConnectionManager.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return rs;
    }
    
    
        public ResultSet executeQueryTransaction(String query, String[] parametter )
    {
        //Connection connect = 
        this.getConnection();
        ResultSet rs = null;
        try 
        {
            PreparedStatement pstat = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            
            if (parametter != null)
            {
                for (int i = 0; i < parametter.length; i++)
                {
                    pstat.setString(i + 1, parametter[i]);
                }
            }
            
            rs = pstat.executeQuery();
            long start = System.currentTimeMillis();
            long end = start + 15*1000; // 60 seconds * 1000 ms/sec
            long count=0;
            while (System.currentTimeMillis() < end)
            {
                count+=10;
            }
            conn.commit();
        } 
        catch (SQLException ex) 
        {
            Logger.getLogger(ConnectionManager.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return rs;
    }
        
        public int executeUpdate(String query, Object[] parametter)
    {
        //Connection connect = 
        this.getConnection();
        int result = -1;
        try 
        {
            PreparedStatement pstat = conn.prepareStatement(query);
            
            if (parametter != null)
            {
                for (int i = 0; i < parametter.length; i++)
                {
                    //pstat.setString(i + 1, parametter[i]);
                    pstat.setObject(i + 1, parametter[i]);
                }
            }
            
            result = pstat.executeUpdate();
            conn.commit();
        } 
        catch (SQLException ex) 
        {
            Logger.getLogger(ConnectionManager.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return result;
    }
    

    
    public int executeUpdateTransaction(String query, Object[] parametter)
    {
        //Connection connect = 
        this.getConnection();
        int result = -1;
        try 
        {
            PreparedStatement pstat = conn.prepareStatement(query);
            
            if (parametter != null)
            {
                for (int i = 0; i < parametter.length; i++)
                {
                    //pstat.setString(i + 1, parametter[i]);
                    pstat.setObject(i + 1, parametter[i]);
                }
            }
            
            result = pstat.executeUpdate();
            long start = System.currentTimeMillis();
            long end = start + 15*1000; // 60 seconds * 1000 ms/sec
            long count=0;
            while (System.currentTimeMillis() < end)
            {
                count+=10;
            }
            conn.commit();
        } 
        catch (SQLException ex) 
        {
            Logger.getLogger(ConnectionManager.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return result;
    }
    
    public Object execute(String query, String[] parametter)
    {
        Connection connect = this.getConnection();
        try 
        {
            PreparedStatement pstat = connect.prepareStatement(query);
            
            if (parametter != null)
            {
                for (int i = 0; i < parametter.length; i++)
                {
                    pstat.setString(i + 1, parametter[i]);
                }
            }
            
            if (pstat.execute())
            {
                conn.commit();
                Object obj = pstat.getUpdateCount();
                return obj;
            }
          
        } 
        catch (SQLException ex) 
        {
            Logger.getLogger(ConnectionManager.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return null;
    }
}
