/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;
import Model.HoaDonModel;
import DataTransfer.HoaDon;
import DataTransfer.NhanVien;
import Model.DangNhapModel;
import java.sql.Date;


/**
 *
 * @author Admin
 */
public class HoaDonController {
    
   private HoaDonController() { }
    
    private static HoaDonController instance;
    
     public static HoaDonController getInstance() {
        if (instance == null)
        {
            instance = new HoaDonController();
        }
        
        return instance;
    }
    
    
     public boolean ThemHoaDon(String TenKM, Date NGAYTAO,int TongTien, int PhaiTra,int KhachDua,int TraLai){
         System.out.print("asdsadasdasdadadas324234234d");
         boolean result= HoaDonModel.getInstance().ThemHoaDon(new HoaDon( TenKM, NGAYTAO, TongTien, PhaiTra, KhachDua, TraLai));
         return result;
     }
}
