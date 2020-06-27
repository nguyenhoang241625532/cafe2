/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import DataProvider.ConnectionManager;
import DataTransfer.KhuyenMai;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author HT
 */
public class QLKMModel {

    private QLKMModel() {  }
    
    private static QLKMModel instance;

    /**
     * @return the instance
     */
    public static QLKMModel getInstance() {
        if (instance == null)
        {
            instance = new QLKMModel();
        }
        
        return instance;
    }
    
    public Vector getDSKM()
    {
        try 
        {
            String query = "select * from KHUYENMAI order by MAKM";
            ResultSet rs = ConnectionManager.getInstance().executeQuery(query, null);
            
            Vector result = new Vector();
            
            while (rs.next())
            {
                Vector row = new Vector();
                
                row.add(rs.getString(1));
                row.add(rs.getString(2));
                row.add(rs.getDate(3));
                row.add(rs.getDate(4));
                row.add(rs.getString(5));
                row.add(rs.getLong(6));
                row.add(rs.getLong(7));
                
                result.add(row);
            }
            
            return result;
        } 
        catch (SQLException ex) 
        {
            Logger.getLogger(QLKMModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public boolean ThemKM(KhuyenMai KM)
    {
        String query = "INSERT INTO KHUYENMAI VALUES ('" + KM.getMaKM() + "','" + KM.getTenKM() + "', TO_DATE('" + (KM.getNgayBatDau()) + "','yyyy-mm-dd'), TO_DATE('" + KM.getNgayKetThuc() + "','yyyy-mm-dd'), '" + KM.getLoaiKM() + "', " + String.valueOf(KM.getTriGiaApDung()) + ", " + String.valueOf(KM.getTriGiaKM()) + ")";
        
        int Row = ConnectionManager.getInstance().executeUpdate(query, null);
        
        if (Row > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
     public boolean CapNhatKM(KhuyenMai KM)
    {

  
       String query ="UPDATE KhuyenMai SET MaKM='" + KM.getMaKM() + "',TenKM='" + KM.getTenKM() + "', ngaybatdau=TO_DATE('" + KM.getNgayBatDau() + "','yyyy-mm-dd'), ngayketthuc=TO_DATE('" + KM.getNgayKetThuc() + "','yyyy-mm-dd'),LoaiKM ='" + KM.getLoaiKM() + "',trigiaapdung=" +String.valueOf(KM.getTriGiaApDung())+", TriGiaKM=" +String.valueOf(KM.getTriGiaKM())+  " WHERE MaKM = '" + KM.getMaKM() + "'";
      System.out.print(query);
        int RowEffect = ConnectionManager.getInstance().executeUpdateTransaction(query, null);
        
        if (RowEffect > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
      public boolean XoaKhuyenMai(String MaKM)
    {
        String query = "DELETE FROM KHUYENMAI WHERE MAKM = '" + MaKM + "'";
       System.out.print(query);
        int Row = ConnectionManager.getInstance().executeUpdate(query, null);
        
        if (Row > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
}
