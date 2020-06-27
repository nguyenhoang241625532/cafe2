/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataTransfer;

import java.sql.Date;

/**
 *
 * @author Admin
 */
public class HoaDon {
    private String TenKM;
    private Date NgayTao;
    private int TongTien;
    private int PhaiTra;
    private int KhachDua;
    private int TraLai;

    public HoaDon(String TenKM, Date NgayTao, int TongTien, int PhaiTra, int KhachDua, int TraLai) {
        this.TenKM = TenKM;
        this.NgayTao = NgayTao;
        this.TongTien = TongTien;
        this.PhaiTra = PhaiTra;
        this.KhachDua = KhachDua;
        this.TraLai = TraLai;
    }

    public HoaDon() {
    }

    public String getTenKM() {
        return TenKM;
    }

    public Date getNgayTao() {
        return NgayTao;
    }

    public int getTongTien() {
        return TongTien;
    }

    public int getPhaiTra() {
        return PhaiTra;
    }

    public int getKhachDua() {
        return KhachDua;
    }

    public int getTraLai() {
        return TraLai;
    }

    public void setTenKM(String TenKM) {
        this.TenKM = TenKM;
    }

    public void setNgayTao(Date NgayTao) {
        this.NgayTao = NgayTao;
    }

    public void setTongTien(int TongTien) {
        this.TongTien = TongTien;
    }

    public void setPhaiTra(int PhaiTra) {
        this.PhaiTra = PhaiTra;
    }

    public void setKhachDua(int KhachDua) {
        this.KhachDua = KhachDua;
    }

    public void setTraLai(int TraLai) {
        this.TraLai = TraLai;
    }
    
    
}
