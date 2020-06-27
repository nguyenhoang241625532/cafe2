/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;
import DataProvider.ConnectionManager;
import DataTransfer.HoaDon;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class HoaDonModel {
    private static HoaDonModel instance;
        private HoaDonModel() { }
    
    /**
     * @return the instance
     */
    public static HoaDonModel getInstance() {
        if (instance == null)
        {
            instance = new HoaDonModel();
        }
        
        return instance;
    }
    
    public boolean ThemHoaDon(HoaDon hd){
        
        String query = "INSERT INTO HOADON (TenKM, NGAYTAO, TONGTIEN, PHAITRA,KHACHDUA,TRALAI) VALUES (?, ?, ?, ?, ?, ?)"; 
        int RowEffect = ConnectionManager.getInstance().executeUpdate(query, new Object[] { hd.getTenKM(),hd.getNgayTao(),hd.getPhaiTra(),
            hd.getTongTien(), hd.getKhachDua(),
            hd.getTraLai() });
        
        System.out.print("asdsadasdasdadadasd");
        if (RowEffect > 0)
        {
            return true;
        }
        else 
        {
            return false;
        }
        

    }
}
