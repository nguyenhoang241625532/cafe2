/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package quanlyquancafe;

import Controller.DangNhapController;
import DataTransfer.NhanVien;
import java.awt.Toolkit;
import java.io.File;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.imageio.ImageIO;
import javax.swing.JFrame;
import javax.swing.JOptionPane;

/**
 *
 * @author HT
 */
public class fmDangNhap extends javax.swing.JFrame {

    private NhanVien nhanvien;
    
    /**
     * Creates new form fmDangNhap
     */
    public fmDangNhap() {
        initComponents();
        //LoadBackground("D:\\Java\\Java Project\\NetBeans\\QuanLyQuanCafe\\src\\img\\background login.jpg");
        this.setSize(520, 328);
        this.setLocation(Toolkit.getDefaultToolkit().getScreenSize().width/2-this.getSize().width/2,
                         Toolkit.getDefaultToolkit().getScreenSize().height/2-this.getSize().height/2);
        
        try {
            this.setIconImage(ImageIO.read(new File(System.getProperty("user.dir") + "\\src\\img\\icon.png")));
        } catch (IOException ex) {
            Logger.getLogger(fmDangNhap.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    boolean isShowing = false;
    
    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jDateChooser1 = new com.toedter.calendar.JDateChooser();
        txtTenDangNhap = new javax.swing.JTextField();
        txtMatKhau = new javax.swing.JPasswordField();
        btnDangNhap = new javax.swing.JButton();
        btnThoat = new javax.swing.JButton();
        jLabel1 = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setTitle("Đăng nhập");
        setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));
        setLocation(new java.awt.Point(0, 0));
        setResizable(false);
        setSize(new java.awt.Dimension(520, 300));
        addWindowListener(new java.awt.event.WindowAdapter() {
            public void windowClosing(java.awt.event.WindowEvent evt) {
                formWindowClosing(evt);
            }
        });
        getContentPane().setLayout(null);

        txtTenDangNhap.setFont(new java.awt.Font("Consolas", 0, 16)); // NOI18N
        getContentPane().add(txtTenDangNhap);
        txtTenDangNhap.setBounds(320, 120, 130, 30);

        txtMatKhau.setFont(new java.awt.Font("Consolas", 0, 16)); // NOI18N
        getContentPane().add(txtMatKhau);
        txtMatKhau.setBounds(320, 160, 130, 30);

        btnDangNhap.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N
        btnDangNhap.setText("Đăng nhập");
        btnDangNhap.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                btnDangNhapMouseClicked(evt);
            }
        });
        getContentPane().add(btnDangNhap);
        btnDangNhap.setBounds(210, 220, 100, 30);

        btnThoat.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N
        btnThoat.setText("Thoát");
        btnThoat.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                btnThoatMouseClicked(evt);
            }
        });
        getContentPane().add(btnThoat);
        btnThoat.setBounds(340, 220, 100, 30);

        jLabel1.setIcon(new javax.swing.ImageIcon(getClass().getResource("/img/Login.png"))); // NOI18N
        getContentPane().add(jLabel1);
        jLabel1.setBounds(0, 0, 520, 300);

        pack();
    }// </editor-fold>//GEN-END:initComponents

    public void ExitProgram(){
        int click = JOptionPane.showConfirmDialog(null, "Bạn có thực sự muốn thoát hay không?", "Thông báo", 
                                                JOptionPane.YES_NO_CANCEL_OPTION, JOptionPane.WARNING_MESSAGE);
        
        if (click == JOptionPane.YES_OPTION){
            isShowing = true;
        }
        else{
            isShowing = false;
        }
    }
    
    private void btnThoatMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_btnThoatMouseClicked
        // TODO add your handling code here:
        //JOptionPane.showInputDialog(this, "Bạn có thực sự muốn thoát hay không?", "Thông báo", JOptionPane.YES_NO_OPTION);
        ExitProgram();
        
        if (isShowing){
            System.exit(0);
        }
        else{
            this.setDefaultCloseOperation(DO_NOTHING_ON_CLOSE);
        }
    }//GEN-LAST:event_btnThoatMouseClicked

    private void formWindowClosing(java.awt.event.WindowEvent evt) {//GEN-FIRST:event_formWindowClosing
        // TODO add your handling code here:
        ExitProgram();
        
        if (isShowing){
            System.exit(0);
        }
        else{
            this.setDefaultCloseOperation(DO_NOTHING_ON_CLOSE);
        }
        
    }//GEN-LAST:event_formWindowClosing

    private void btnDangNhapMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_btnDangNhapMouseClicked
        // TODO add your handling code here:
        String strMatKhau = new String(txtMatKhau.getPassword());
        
        if (txtTenDangNhap.getText().isEmpty())
        {
            JOptionPane.showMessageDialog(null, "Bạn chưa nhập tên tài khoản\n Vui lòng nhập lại !", "Thông báo", 
                                                JOptionPane.OK_OPTION);
            txtTenDangNhap.requestFocus();
            return;
        }
        
        if (strMatKhau.isEmpty())
        {
            JOptionPane.showMessageDialog(null, "Bạn chưa nhập mật khẩu\n Vui lòng nhập lại !", "Thông báo", 
                                                JOptionPane.OK_OPTION);
            txtMatKhau.requestFocus();
            return;
        }
        
        nhanvien = DangNhapController.getInstance().XacThucDangNhap(txtTenDangNhap.getText(), strMatKhau);
        
        if (nhanvien == null)
        {
            JOptionPane.showMessageDialog(null, "Bạn nhập sai tài khoản hoặc sai mật khẩu\n Vui lòng nhập lại !", "Thông báo", 
                                                JOptionPane.OK_OPTION);
            txtTenDangNhap.requestFocus();
        }
        else
        {
            fmMain main = new fmMain(nhanvien);
            main.setVisible(true);
            this.setVisible(false);
        }

    }//GEN-LAST:event_btnDangNhapMouseClicked

    
    /* void LoadBackground(String path){
        try {
            BufferedImage brImg = ImageIO.read(new File(path));
            
            int x = jLabel1.getSize().width;
            int y = jLabel1.getSize().height;
            
            int ix = brImg.getWidth();
            int iy = brImg.getHeight();
            int dx = 0;
            int dy = 0;
            
            if (x / y > ix / iy) {
                dy = y;
                dx = dy * ix / iy;
            } else {
                dx = x;
                dy = dx * iy / ix;
            }
            
            ImageIcon img = new ImageIcon(brImg.getScaledInstance(dx, dy, brImg.SCALE_SMOOTH));
            jLabel1.setIcon(img);
        } catch (IOException ex) {
            Logger.getLogger(fmDangNhap.class.getName()).log(Level.SEVERE, null, ex);
        }
    }*/
    
    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(fmDangNhap.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(fmDangNhap.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(fmDangNhap.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(fmDangNhap.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            @Override
            public void run() {
                fmDangNhap dangnhap = new fmDangNhap();
                dangnhap.setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btnDangNhap;
    private javax.swing.JButton btnThoat;
    private com.toedter.calendar.JDateChooser jDateChooser1;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JPasswordField txtMatKhau;
    private javax.swing.JTextField txtTenDangNhap;
    // End of variables declaration//GEN-END:variables
}