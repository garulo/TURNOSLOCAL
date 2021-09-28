/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sadm.turnos.controlador;

import com.sadm.turnos.dao.Turno;
import java.sql.PreparedStatement;


import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

public class ConsultasCentral extends ConexionDBCentral {

    /*
     *enviarTurnosCentral
     */
    public boolean enviarTurnosCentral(List<Turno> lstTurnos) {
        System.out.println("enviarTurnosCentral / Consultas Central");
        PreparedStatement pst = null;
        DateFormat dateFt = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Calendar cl = Calendar.getInstance();
        String fechaT = dateFt.format(cl.getTime());
        if (lstTurnos.size() > 0) {

            try {
                for (Turno t : lstTurnos) {
                    String consulta = "INSERT INTO `turnos_central`.`turnos_central` (`idTurno`, `intTurno`, `intVentanilla`, `intServicio`, `strCliente`, `strEstatusTurno`, `strTipoTurno`, `dtmFechaEspera`, `dtmFechaAtencion`, `intOficinadeServicios`, `dtmFechaTermino`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
                    pst = getConexion().prepareStatement(consulta);

                    pst.setString(1, t.getIdTurno());
                    pst.setString(2, t.getIntTurno());
                    pst.setString(3, t.getIntVentanilla());
                    pst.setString(4, t.getIntServicio());
                    pst.setString(5, t.getStrCliente());
                    pst.setString(6, t.getStrEstatusTurno());
                    pst.setString(7, t.getStrTipoTurno());
                    pst.setString(8, t.getDtmFechaEspera());
                    pst.setString(9, t.getDtmFechaAtencion());
                    pst.setString(10, t.getIntOficinadeServicios());
                    pst.setString(11, t.getDtmFechaTermino());

                    if (pst.executeUpdate() == 1) {
                        System.out.println("Turno Insertado a Central :::" + fechaT);

                    }
                }

            } catch (Exception e) {
                System.err.println("catch Error: " + e);
            } finally {
                try {
                    if (getConexion() != null) {
                        getConexion().close();
                    }
                    if (pst != null) {
                        pst.close();
                    }
                } catch (Exception e) {

                    System.err.println("finally Error: " + e);
                }

            }
        }

        return false;
    }
    //TEST de enviarTurnosCentral
/*
     public static void main(String[] args) {
     ConsultasCentral co = new ConsultasCentral();
     List<Turno> lstTurno = new ArrayList<>();
     Turno tu = new Turno();
     tu.setIntTurno("AA-007");
     tu.setDtmFechaAtencion("2020/03/04 11:35:55");
     tu.setIntOficinadeServicios("1");
     lstTurno.add(tu);
     boolean servicio = co.enviarTurnosCentral(lstTurno);
     System.out.println("reasignarTurno :::" + servicio);
     }
     */

    /*
     *enviarTurnosCentral
     */
    public boolean enviarTurnosEnLinea(List<Turno> lstTurnos) {
        System.out.println("enviarTurnosEnLinea / Consultas Central");
        PreparedStatement pst = null;
        DateFormat dateFt = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Calendar cl = Calendar.getInstance();
        String fechaT = dateFt.format(cl.getTime());
        System.out.println(":::::: lstTurnos.size() " + lstTurnos.size());
        if (!lstTurnos.isEmpty()) {

            try {
                for (Turno t : lstTurnos) {
                    String consulta = "INSERT INTO turnos_central(idTurno,intTurno,intVentanilla,intServicio,strCliente,strEstatusTurno,strTipoTurno,dtmFechaEspera,dtmFechaAtencion,intOficinadeServicios,dtmFechaTermino,strIdUserAttending,strUserAttending,strEstatusAtencion,valPreferencial,strTipoServicio) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)";
                    //System.out.println("consulta: " + consulta);
                    //System.out.println("pst central: " + t.getIdTurno() + "/" + t.getStrEstatusTurno() + "/" + t.getIntTurno() + "/" + t.getIntVentanilla() + "/" + t.getIntServicio() + "/" + t.getStrCliente() + "/" + t.getStrTipoTurno() + "/" + t.getDtmFechaEspera() + "/" + t.getDtmFechaAtencion() + "/" + t.getIntOficinadeServicios() + "/" + t.getDtmFechaTermino());

                     pst = getConexion().prepareStatement(consulta);

                    pst.setString(1, t.getIdTurno());
                    pst.setString(2, t.getIntTurno());
                    pst.setString(3, t.getIntVentanilla());
                    pst.setString(4, t.getIntServicio());
                    pst.setString(5, t.getStrCliente());
                    pst.setString(6, t.getStrEstatusTurno());
                    pst.setString(7, t.getStrTipoTurno());
                    pst.setString(8, t.getDtmFechaEspera());
                    pst.setString(9, t.getDtmFechaAtencion());
                    pst.setString(10, t.getIntOficinadeServicios());
                    pst.setString(11, t.getDtmFechaTermino());
                    pst.setString(12, t.getStrIdUserAttending());
                    pst.setString(13, t.getStrUserAttending());
                    pst.setString(14, t.getStrEstatusAtencion());
                    pst.setString(15, t.getValPreferencial());
                    pst.setString(16, t.getStrTipoServicio());
                    
                    System.out.println("pst central: " + pst);
                    if (pst.executeUpdate() == 1) {
                        System.out.println("Turno Insertado a Central :::" + fechaT);
                        Consultas con = new Consultas();
                        boolean a = con.actualizarturnoenviado(t.getIdTurno());
                        System.out.println("Id Turno enviado a central " + a + " :: " + t.getIdTurno() + " :: " + t.getIntTurno());

                    } else {
                        System.out.println("Error en Turno Insertado a Central :::" + fechaT + " / " + t.getIdTurno());
                    }
                }

            } catch (Exception e) {
                System.err.println("catch Error try enviarTurnosEnLinea: " + e);
            } finally {
                try {
                    if (getConexion() != null) {
                        getConexion().close();
                    }
                    if (pst != null) {
                        pst.close();
                    }
                } catch (Exception e) {

                    System.err.println("finally Error: " + e);
                }

            }
        }

        return false;
    }
    //TEST de enviarTurnosCentral

//     public static void main(String[] args) {
//     ConsultasCentral co = new ConsultasCentral();
//      List<Turno> lstTurno = new ArrayList<>();
//     Turno tu = new Turno();
//     tu.setIntTurno("AA-007");
//     tu.setDtmFechaAtencion("2020/03/04 11:35:55");
//     tu.setIntOficinadeServicios("1");
//     lstTurno.add(tu);
//     boolean servicio = co.enviarTurnosEnLinea(lstTurno);
//     System.out.println("enviarTurnosEnLinea :::" + servicio);
//     }
    
    
    
    //selectTipoServ
     public List<String> selectTipoServ(String tipoServ) {

        PreparedStatement pst = null;
        ResultSet rs = null;
        List<String> lstTip = new ArrayList<>();

        try {
           // System.out.println("Script ::: select Nombre as tipo from cat_tipo_servicios where Descripcion='"+tipoServ+"'");
            String consulta = "select Nombre as tipo from cat_tipo_servicios where Descripcion=?";
            pst = getConexion().prepareStatement(consulta);
             pst.setString(1, tipoServ);
            
            rs = pst.executeQuery();

            while (rs.next()) {
                lstTip.add(rs.getString("tipo"));

            }

         

        } catch (Exception e) {
            System.err.println("catch Error: " + e);
        } finally {
            try {
                if (getConexion() != null) {
                    getConexion().close();
                }
                if (pst != null) {
                    pst.close();
                }
            } catch (Exception e) {

                System.err.println("finally Error: " + e);
            }

        }
        return lstTip;
    }
}
