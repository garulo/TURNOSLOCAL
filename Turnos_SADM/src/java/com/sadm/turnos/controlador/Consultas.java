package com.sadm.turnos.controlador;

import com.sadm.turnos.dao.Oficina;
import com.sadm.turnos.dao.ProxTurnos;
import com.sadm.turnos.dao.RepAtendidos;
import com.sadm.turnos.dao.RepTiempoServicio;
import com.sadm.turnos.dao.RepTiempoTicket;
import com.sadm.turnos.dao.Servicio;
import com.sadm.turnos.dao.Turno;
import com.sadm.turnos.dao.UltTurnos;
import com.sadm.turnos.dao.Usuario;
import com.sadm.turnos.dao.Ventanilla;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Formatter;
import java.util.List;
import java.util.StringTokenizer;
import java.util.UUID;

public class Consultas extends ConexionDB {

    /*
     * USUARIOS
     */
    //AUTENTICACIÓN DE USUARIO
    public Usuario autenticacion(String usuario, String password) {

        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            String consulta = "select * from usuarios where usuario = ? and password= ? and estatus ='1' and idRol<>'1';";
            pst = getConexion().prepareStatement(consulta);
            pst.setString(1, usuario);
            pst.setString(2, password);

            rs = pst.executeQuery();

            Usuario user = new Usuario();
            while (rs.next()) {
                user = new Usuario();
                user.setId(rs.getString("id"));
                user.setUsuario(rs.getString("usuario"));
                user.setPassword(rs.getString("password"));
                user.setNombre(rs.getString("nombre"));
                user.setEmail(rs.getString("email"));
                user.setIdRol(rs.getString("idRol"));
                user.setEstatus(rs.getString("estatus"));
                user.setFecha(rs.getString("fecha"));

            }

            System.out.println("USUARIO ::: " + user.getNombre());
            return user;

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

        return null;
    }

    //TEST de autenticacion
    /*
     public static void main(String[] args) {
     Consultas co = new Consultas();
     Usuario user = new Usuario();
     user = co.autenticacion("UserAdminTest", "PassTest");
     System.out.println("idRol ::: "+user.getIdRol());

     }*/
    //agregarUsuarioVentanilla 
    public boolean agregarUsuarioVentanilla(String txtAgregarUUsuario, String txtAgregarUNombre, String txtAgregarUPass, String txtAgregarUEmail, String txtAgregarUVent, String txtAgregarUEstatus, String useragr) {

        PreparedStatement pst = null;
        String uid = UUID.randomUUID().toString();
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Calendar cal = Calendar.getInstance();
        String fecha = dateFormat.format(cal.getTime());

        try {
            String consulta = "INSERT INTO `turnos`.`usuarios` (`id`, `usuario`, `password`, `nombre`, `email`, `idRol`, `estatus`, `fecha`, `ventanilla`) VALUES (?,?,?,?,?,?,?,?,?);";
            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, uid);
            pst.setString(2, txtAgregarUUsuario);
            pst.setString(3, txtAgregarUPass);
            pst.setString(4, txtAgregarUNombre);
            pst.setString(5, txtAgregarUEmail);
            pst.setString(6, "3");
            pst.setString(7, txtAgregarUEstatus);
            pst.setString(8, fecha);
            pst.setString(9, txtAgregarUVent);

            System.out.println("pst UPDATE ::: " + pst);

            if (pst.executeUpdate() == 1) {
                System.out.println("Usuario Agregado :::" + txtAgregarUUsuario);

                PreparedStatement pstz = null;
                DateFormat dateFormatz = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                Calendar calz = Calendar.getInstance();
                String fechaz = dateFormatz.format(calz.getTime());
                String consultaz = new String();
                pstz = null;
                dateFormatz = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                calz = Calendar.getInstance();
                fechaz = dateFormatz.format(calz.getTime());
                consultaz = new String();
                consultaz = "UPDATE `turnos`.`ventanillas` SET `UsuarioAsignado`= ? , `UsuarioLastUpdate`= ? , `FechaLastUpdate`= ?  WHERE (`NombreVentanilla`= ? );";
                pstz = getConexion().prepareStatement(consultaz);

                pstz.setString(1, txtAgregarUUsuario);
                pstz.setString(2, useragr);
                pstz.setString(3, fechaz);
                pstz.setString(4, txtAgregarUVent);

                System.out.println("pstz UPDATE ::: " + pstz);

                if (pstz.executeUpdate() == 1) {
                    System.out.println("Usuario - Ventanilla Agregados :::" + txtAgregarUVent + " ::: " + txtAgregarUUsuario);
                } else {
                    System.out.println("Usuario - Ventanilla ERROR AGREGAR :::" + txtAgregarUVent + " ::: " + txtAgregarUUsuario);
                }

                return true;
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

        return false;
    }

    //TEST de agregarVentanilla
    /*
     public static void main(String[] args) {
     Consultas co = new Consultas();
     boolean servicio = co.agregarUsuarioVentanilla("Usuario", "Nombre", "Pass", "Email", "04", "1", "localprueba");
     System.out.println("Ventanilla Agregada :::" + servicio);
     }
     */
    //editarVentUsuario 
    public boolean editarVentUsuario(String txtEditarUIdDet, String txtEditarUVentDetalle, String nomVent) {

        PreparedStatement pst = null;
        PreparedStatement pstz = null;
        PreparedStatement pstzz = null;
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Calendar cal = Calendar.getInstance();
        String fecha = dateFormat.format(cal.getTime());

        try {
            String consulta = "UPDATE `turnos`.`usuarios` SET  `ventanilla`= ? WHERE (`id`= ? );";
            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, txtEditarUVentDetalle);
            pst.setString(2, txtEditarUIdDet);

            System.out.println("pst UPDATE ::: " + pst);

            if (pst.executeUpdate() == 1) {
                System.out.println("Usuario Editado :::" + txtEditarUIdDet);

                String consultaz = new String();
                pstz = null;
                consultaz = new String();

                if (txtEditarUVentDetalle.equals("")) {
                    consultaz = "UPDATE `turnos`.`ventanillas` SET `UsuarioAsignado`= ''  WHERE (`NombreVentanilla`= ? );";
                    pstz = getConexion().prepareStatement(consultaz);
                    pstz.setString(1, nomVent);

                    System.out.println("pstz UPDATE ::: " + pstz);

                    if (pstz.executeUpdate() == 1) {
                        System.out.println("Usuario - Ventanilla Editado :::" + txtEditarUVentDetalle + " ::: " + txtEditarUIdDet);
                    } else {
                        System.out.println("Usuario - Ventanilla ERROR Editar :::" + txtEditarUVentDetalle + " ::: " + txtEditarUIdDet);
                    }

                } else {
                    consultaz = "UPDATE `turnos`.`ventanillas` SET `UsuarioAsignado`= (select usuario from usuarios where id= ? )  WHERE (`NombreVentanilla`= ? );";
                    pstz = getConexion().prepareStatement(consultaz);
                    pstz.setString(1, txtEditarUIdDet);
                    pstz.setString(2, txtEditarUVentDetalle);

                    System.out.println("pstz UPDATE ::: " + pstz);

                    if (pstz.executeUpdate() == 1) {
                        String consultazz = new String();
                        pstzz = null;
                        consultazz = new String();

                        consultazz = "UPDATE `turnos`.`ventanillas` SET `UsuarioAsignado`= ''  WHERE (`NombreVentanilla`= ? );";
                        pstzz = getConexion().prepareStatement(consultazz);
                        pstzz.setString(1, nomVent);

                        System.out.println("pstzz UPDATE ::: " + pstz);

                        if (pstzz.executeUpdate() == 1) {
                            System.out.println("Usuario - Ventanilla Borrado :::" + txtEditarUVentDetalle + " ::: ");
                        } else {
                            System.out.println("Usuario - Ventanilla ERROR Borrado :::" + txtEditarUVentDetalle + " ::: ");
                        }

                        System.out.println("Usuario - Ventanilla Editado :::" + txtEditarUVentDetalle + " ::: " + txtEditarUIdDet);
                    } else {
                        System.out.println("Usuario - Ventanilla ERROR Editar :::" + txtEditarUVentDetalle + " ::: " + txtEditarUIdDet);
                    }

                }

                return true;
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
                if (pstz != null) {
                    pstz.close();
                }
                if (pstzz != null) {
                    pstzz.close();
                }
            } catch (Exception e) {

                System.err.println("finally Error: " + e);
            }

        }

        return false;
    }

    //TEST de editarVentUsuario
    /*
     public static void main(String[] args) {
     Consultas co = new Consultas();
     boolean servicio = co.editarVentUsuario("606b9ad2-9da7-44fa-ad3f-703bf9ec2874", "","02");
     System.out.println("Ventanilla Agregada :::" + servicio);
     }
     */
    //editarUsuario 
    public boolean editarUsuario(String txtEditarUId, String txtEditarUUsu, String txtEditarUNombre, String txtEditarUPass, String txtEditarUEmail, String txtEditarUVent, String txtEditarUEstatus, String txtusredit) {

        PreparedStatement pst = null;
        PreparedStatement pstz = null;
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Calendar cal = Calendar.getInstance();
        String fecha = dateFormat.format(cal.getTime());

        try {
            String consulta = "UPDATE `turnos`.`usuarios` SET  `usuario`= ? , `password`= ?, `nombre`= ? , `email`= ? ,  `estatus`= ? , `fecha`= ? , `ventanilla`= ?  WHERE (`id`= ? );";
            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, txtEditarUUsu);
            pst.setString(2, txtEditarUPass);
            pst.setString(3, txtEditarUNombre);
            pst.setString(4, txtEditarUEmail);
            pst.setString(5, txtEditarUEstatus);
            pst.setString(6, fecha);

            pst.setString(7, txtEditarUVent);
            pst.setString(8, txtEditarUId);

            System.out.println("pst UPDATE ::: " + pst);

            if (pst.executeUpdate() == 1) {
                System.out.println("Usuario Editado :::" + txtEditarUNombre);

                DateFormat dateFormatz = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                Calendar calz = Calendar.getInstance();
                String fechaz = dateFormatz.format(calz.getTime());
                String consultaz = new String();
                pstz = null;
                dateFormatz = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                calz = Calendar.getInstance();
                fechaz = dateFormatz.format(calz.getTime());
                consultaz = new String();
                consultaz = "UPDATE `turnos`.`ventanillas` SET `UsuarioAsignado`= ? , `UsuarioLastUpdate`= ? , `FechaLastUpdate`= ?  WHERE (`NombreVentanilla`= ? );";
                pstz = getConexion().prepareStatement(consultaz);

                pstz.setString(1, txtEditarUUsu);
                pstz.setString(2, txtusredit);
                pstz.setString(3, fechaz);
                pstz.setString(4, txtEditarUVent);

                System.out.println("pstz UPDATE ::: " + pstz);

                if (pstz.executeUpdate() == 1) {
                    System.out.println("Usuario - Ventanilla Editado :::" + txtEditarUVent + " ::: " + txtEditarUUsu);
                } else {
                    System.out.println("Usuario - Ventanilla ERROR Editar :::" + txtEditarUVent + " ::: " + txtEditarUUsu);
                }

                return true;
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
                if (pstz != null) {
                    pstz.close();
                }
            } catch (Exception e) {

                System.err.println("finally Error: " + e);
            }

        }

        return false;
    }

    //TEST de editarUsuario
    /*
     public static void main(String[] args) {
     Consultas co = new Consultas();
     boolean servicio = co.agregarUsuarioVentanilla("Usuario", "Nombre", "Pass", "Email", "04", "1", "localprueba");
     System.out.println("Ventanilla Agregada :::" + servicio);
     }
     */
    //eliminarUsuario 
    public boolean eliminarUsuario(String idUsElim) {

        PreparedStatement pst9 = null;
        PreparedStatement pstz = null;

        try {

            DateFormat dateFormatz = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
            Calendar calz = Calendar.getInstance();
            String fechaz = dateFormatz.format(calz.getTime());
            String consultaz = new String();
            pstz = null;
            dateFormatz = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
            calz = Calendar.getInstance();
            fechaz = dateFormatz.format(calz.getTime());
            consultaz = new String();
            consultaz = "UPDATE `turnos`.`ventanillas` SET `UsuarioAsignado`= ''  WHERE (`UsuarioAsignado`= (select usuario from usuarios where id= ? ) );";
            pstz = getConexion().prepareStatement(consultaz);

            pstz.setString(1, idUsElim);

            System.out.println("pstz UPDATE ::: " + pstz);

            if (pstz.executeUpdate() == 1) {
                System.out.println("Usuario - Ventanilla Eliminado :::" + idUsElim);
            } else {
                System.out.println("Usuario - Ventanilla ERROR eliminar :::" + idUsElim);
            }

            String consulta9 = "delete from usuarios where id = ? ;";
            pst9 = getConexion().prepareStatement(consulta9);
            pst9.setString(1, idUsElim);

            if (pst9.executeUpdate() >= 1) {
                System.out.println("Usuario eliminado :::" + idUsElim);

            }

            return true;

        } catch (Exception e) {
            System.err.println("catch Error: " + e);
        } finally {
            try {
                if (getConexion() != null) {
                    getConexion().close();
                }
                if (pstz != null) {
                    pstz.close();
                }
                if (pst9 != null) {
                    pst9.close();
                }
            } catch (Exception e) {

                System.err.println("finally Error: " + e);
            }

        }

        return false;
    }
    //TEST de eliminarUsuario

    /*public static void main(String[] args) {
     Consultas co = new Consultas();

     boolean servicio = co.eliminarUsuario("8baf4c07-8fe0-4ac3-9e7b-ed17319eec11");
     System.out.println("Eliminar Usuario test  :::" + servicio);
     }*/
 /*
     //Obtener allUsuariosgral 
     */
    public List<Usuario> allUsuariosgral() {

        PreparedStatement pst = null;
        ResultSet rs = null;
        Usuario usuario;
        List<Usuario> lstUsu = new ArrayList<>();

        try {
            String consulta = "select u.id as id,u.usuario as usuario,u.password as password,u.nombre as nombre,u.email as email,u.idRol as idRol,u.estatus as estatus,u.fecha as fecha,v.NombreVentanilla as ventanilla from usuarios u, ventanillas v where u.idRol='3' and v.UsuarioAsignado=u.usuario;";
            pst = getConexion().prepareStatement(consulta);

            rs = pst.executeQuery();

            while (rs.next()) {
                usuario = new Usuario();
                usuario.setId(rs.getString("id"));
                usuario.setUsuario(rs.getString("usuario"));
                usuario.setPassword(rs.getString("password"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setEmail(rs.getString("email"));
                usuario.setIdRol(rs.getString("idRol"));
                usuario.setEstatus(rs.getString("estatus"));
                usuario.setFecha(rs.getString("fecha"));

                lstUsu.add(usuario);

            }

            return lstUsu;

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
        return lstUsu;
    }
    //TEST de allUsuarios

    /*
     public static void main(String[] args) {
     Consultas co = new Consultas();
     List<Usuario> lstUsu = new ArrayList();
     lstUsu = co.allUsuariosgral();
     System.out.println("Lista de usuarios :::" + lstUsu.size()); 
     }
     */
    //Obtener all allUsuarios 
    public List<Usuario> allUsuarios() {

        PreparedStatement pst = null;
        ResultSet rs = null;
        Usuario usuario;
        List<Usuario> lstUsu = new ArrayList<>();

        try {
            String consulta = "select * from usuarios where idRol='3';";
            pst = getConexion().prepareStatement(consulta);

            rs = pst.executeQuery();

            while (rs.next()) {
                usuario = new Usuario();
                usuario.setId(rs.getString("id"));
                usuario.setUsuario(rs.getString("usuario"));
                usuario.setPassword(rs.getString("password"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setEmail(rs.getString("email"));
                usuario.setIdRol(rs.getString("idRol"));
                usuario.setEstatus(rs.getString("estatus"));
                usuario.setFecha(rs.getString("fecha"));
                usuario.setVentanilla(rs.getString("ventanilla"));

                lstUsu.add(usuario);

            }

            return lstUsu;

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
        return lstUsu;
    }
    //TEST de allUsuarios

    /*
     public static void main(String[] args) {
     Consultas co = new Consultas();
     List<Usuario> lstUsu = new ArrayList();
     lstUsu = co.allUsuarios();
     System.out.println("Lista de usuarios :::" + lstUsu.size()); 
     }
     */
 /*
     * SERVICIOS
     */
    //CONSULTA DE SERVICIOS ACTIVOS 
    public List<Servicio> serviciosActivos() {

        PreparedStatement pst = null;
        ResultSet rs = null;
        List<Servicio> lstServ = new ArrayList<Servicio>();

        try {
            String consulta = "Select * from servicios where Estatus='1';";
            pst = getConexion().prepareStatement(consulta);
            //pst.setString(1, idOficina);

            rs = pst.executeQuery();

            while (rs.next()) {
                Servicio serv = new Servicio();
                serv.setId(rs.getString("id"));
                serv.setDescripcionServicio(rs.getString("DescripcionServicio"));
                serv.setEstatus(rs.getString("Estatus"));
                serv.setUserLastUpdate(rs.getString("UserLastUpdate"));
                serv.setFechaLastUpdate(rs.getString("FechaLastUpdate"));
                serv.setColor(rs.getString("Color"));

                lstServ.add(serv);
            }

            return lstServ;

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

        return null;
    }

    //TEST de serviciosActivos
    /*
     public static void main(String[] args) {
     Consultas co = new Consultas();
     List<Servicio> lstServ = new ArrayList<Servicio>();
     lstServ = co.serviciosActivos();
     
     for(Servicio s : lstServ)
     {
     System.out.println("SERVICIO ::: "+s.getDescripcionServicio());
     }
    
     }
     */
    //CONSULTA DE SERVICIOS ACTIVOS 
    public Servicio obtenerServicio(String Idservicio) {

        PreparedStatement pst = null;
        ResultSet rs = null;
        Servicio servicio = new Servicio();

        try {
            String consulta = "Select * from servicios where id=?;";
            pst = getConexion().prepareStatement(consulta);
            pst.setString(1, Idservicio);

            rs = pst.executeQuery();

            while (rs.next()) {

                servicio.setId(rs.getString("id"));
                servicio.setDescripcionServicio(rs.getString("DescripcionServicio"));
                servicio.setEstatus(rs.getString("Estatus"));
                servicio.setUserLastUpdate(rs.getString("UserLastUpdate"));
                servicio.setFechaLastUpdate(rs.getString("FechaLastUpdate"));
                servicio.setColor(rs.getString("Color"));
                servicio.setPrefijo(rs.getString("prefijo"));

            }

            return servicio;

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

        return null;
    }

    //TEST de serviciosActivos
    /*
     public static void main(String[] args) {
     Consultas co = new Consultas();
     Servicio servicio = new Servicio();
     servicio = co.obtenerServicio("21fa5d9f-e04a-4b72-ab99-00f5d6f331f7");
     System.out.println("Servicio :::" + servicio.getDescripcionServicio() ); 
     }*/
 /*
     * CONFIG
     */
    //editarVideo 
    public boolean editarVideo(String TxtViNameSelected) {

        PreparedStatement pst = null;

        try {
            String consulta = "UPDATE `turnos`.`oficinalocal` SET  `video`= ? ;";
            pst = getConexion().prepareStatement(consulta);
            pst.setString(1, TxtViNameSelected);

            System.out.println("pst UPDATE ::: " + pst);

            if (pst.executeUpdate() == 1) {
                System.out.println("Video Editado :::" + TxtViNameSelected);

                return true;
            } else {
                System.out.println("Video No Editado :::" + TxtViNameSelected);
                return false;
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

        return false;
    }

    //TEST de editarVideo
    /*
     public static void main(String[] args) {
     Consultas co = new Consultas();
     boolean servicio = co.editarVideo("Prueba");
     System.out.println("Video Actualizado :::" + servicio);
     }
     */
    //Obtener oficina 
    public Oficina consulNombreOficina() {

        PreparedStatement pst = null;
        ResultSet rs = null;
        Oficina ofi = new Oficina();

        try {
            String consulta = "Select * from oficinalocal;";
            pst = getConexion().prepareStatement(consulta);
            rs = pst.executeQuery();
            System.out.println("pst ::: " + pst);

            while (rs.next()) {
                ofi = new Oficina();
                ofi.setId(rs.getString("idOficina"));
                ofi.setNombre(rs.getString("Nombre"));
                ofi.setDesc(rs.getString("Desc"));
                ofi.setVideo(rs.getString("video"));
                ofi.setPoster(rs.getString("poster"));
                ofi.setNum(rs.getString("num"));

            }

            return ofi;

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
        return ofi;
    }
    //TEST de serviciosActivos
/*
     public static void main(String[] args) {
     Consultas co = new Consultas();
     Oficina oficina = new Oficina();
     oficina = co.consulNombreOficina();
     System.out.println("Nombre de oficina :::" + oficina.getNombre());
     }
     */

 /*
     * VENTANILLAS
     */
    //Obtener ventanilla 
    public String consulVentanilla(String user) {

        PreparedStatement pst = null;
        ResultSet rs = null;
        String ventanilla = new String();

        try {
            String consulta = "Select NombreVentanilla from ventanillas where UsuarioAsignado= ? ;";
            pst = getConexion().prepareStatement(consulta);
            pst.setString(1, user);

            rs = pst.executeQuery();

            while (rs.next()) {

                ventanilla = rs.getString("NombreVentanilla");

            }

            return ventanilla;

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
        return ventanilla;
    }
    //TEST de consulVentanilla

    /*
     public static void main(String[] args) {
     Consultas co = new Consultas();
     String ventanilla = new String();
     ventanilla = co.consulVentanilla("UserVentanillaTest");
     System.out.println("Nombre de oficina :::" + ventanilla); 
     }
     */
    //Obtener all ventanillas 
    public List<Ventanilla> allVentanillas() {

        PreparedStatement pst = null;
        ResultSet rs = null;
        Ventanilla ventanilla;
        List<Ventanilla> lstVent = new ArrayList<>();

        try {
            String consulta = "select * from ventanillas;";
            pst = getConexion().prepareStatement(consulta);

            rs = pst.executeQuery();

            while (rs.next()) {
                ventanilla = new Ventanilla();
                ventanilla.setId(rs.getString("idVentanilla"));
                ventanilla.setNombre(rs.getString("NombreVentanilla"));
                ventanilla.setDesc(rs.getString("DescVentanilla"));
                ventanilla.setUsuario(rs.getString("UsuarioAsignado"));
                ventanilla.setUsuLstUpdt(rs.getString("UsuarioLastUpdate"));
                ventanilla.setDtLstUpdt(rs.getString("FechaLastUpdate"));
                ventanilla.setServicios(rs.getString("servicios"));

                lstVent.add(ventanilla);

            }

            return lstVent;

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
        return lstVent;
    }
    //TEST de allVentanillas

    /*
     public static void main(String[] args) {
     Consultas co = new Consultas();
     List<Ventanilla> lstVent = new ArrayList();
     lstVent = co.allVentanillas();
     System.out.println("Lista de ventaniillas :::" + lstVent.size()); 
     }
     */
    //Obtener all ventanillas 
    public List<Ventanilla> allVentanillasDisponibles() {

        PreparedStatement pst = null;
        ResultSet rs = null;
        Ventanilla ventanilla;
        List<Ventanilla> lstVent = new ArrayList<>();

        try {
            String consulta = "select * from ventanillas where UsuarioAsignado = '';";
            pst = getConexion().prepareStatement(consulta);

            rs = pst.executeQuery();

            while (rs.next()) {
                ventanilla = new Ventanilla();
                ventanilla.setId(rs.getString("idVentanilla"));
                ventanilla.setNombre(rs.getString("NombreVentanilla"));
                ventanilla.setDesc(rs.getString("DescVentanilla"));
                ventanilla.setUsuario(rs.getString("UsuarioAsignado"));
                ventanilla.setUsuLstUpdt(rs.getString("UsuarioLastUpdate"));
                ventanilla.setDtLstUpdt(rs.getString("FechaLastUpdate"));
                ventanilla.setServicios(rs.getString("servicios"));

                lstVent.add(ventanilla);

            }

            return lstVent;

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
        return lstVent;
    }
    //TEST de allVentanillas

    /*
     public static void main(String[] args) {
     Consultas co = new Consultas();
     List<Ventanilla> lstVent = new ArrayList();
     lstVent = co.allVentanillas();
     System.out.println("Lista de ventaniillas :::" + lstVent.size()); 
     }
     */
    //Obtener ServActVent
    public List<String> ServActVent(String name) {

        PreparedStatement pst = null;
        ResultSet rs = null;
        String Srv;
        List<String> lstSrv = new ArrayList<>();

        try {
            String consulta = "select NombreServicio from servicio_ventanillas sv, servicios s where sv.NombreVentanilla =? and s.DescripcionServicio = sv.NombreServicio and s.Estatus='1';";
            pst = getConexion().prepareStatement(consulta);
            pst.setString(1, name);
            rs = pst.executeQuery();

            while (rs.next()) {
                Srv = new String();
                Srv = rs.getString("NombreServicio");

                lstSrv.add(Srv);

            }

            return lstSrv;

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
        return lstSrv;
    }
    //TEST de ServActVent

    /*
     public static void main(String[] args) {
     Consultas co = new Consultas();
     List<String> lstVent = new ArrayList();
     lstVent = co.ServActVent("01");
     System.out.println("Lista servicios activos de ventaniillas :::" + lstVent.size()); 
     }
     */
    //eliminarVentanilla 
    public boolean eliminarVentanilla(String idVentElim) {

        PreparedStatement pst9 = null;
        PreparedStatement pst = null;

        try {

            String consulta9 = "delete from servicio_ventanillas where NombreVentanilla = (select NombreVentanilla from ventanillas where idVentanilla='" + idVentElim + "');";
            pst9 = getConexion().prepareStatement(consulta9);

            if (pst9.executeUpdate() >= 1) {
                System.out.println("Relacion Ventanilla Servicios Eliminada :::" + idVentElim);

            }

            String consulta = "delete from ventanillas where idVentanilla='" + idVentElim + "';";
            pst = getConexion().prepareStatement(consulta);

            if (pst.executeUpdate() == 1) {
                System.out.println("Ventanilla Eliminada :::" + idVentElim);
                return true;
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
                if (pst9 != null) {
                    pst9.close();
                }
            } catch (Exception e) {

                System.err.println("finally Error: " + e);
            }

        }

        return false;
    }

    //TEST de eliminarVentanilla
    /*
     public static void main(String[] args) {
     Consultas co = new Consultas();

     boolean servicio = co.eliminarVentanilla("ea296b4b-6160-44db-b578-c1eb8750cad9");
     System.out.println("Eliminar Ventanilla test  :::" + servicio);
     }
     */
    //agregarVentanilla 
    public boolean agregarVentanilla(String agreVentNombre, String agreVentDesc, String agreVentServ, String usuario) {

        PreparedStatement pst = null;
        String uid = UUID.randomUUID().toString();
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Calendar cal = Calendar.getInstance();
        String fecha = dateFormat.format(cal.getTime());

        try {
            String consulta = "INSERT INTO `turnos`.`ventanillas` (`idVentanilla`, `NombreVentanilla`, `DescVentanilla`, `UsuarioAsignado`, `UsuarioLastUpdate`, `FechaLastUpdate`, `LastTurnAtended`, `servicios`) VALUES(?,?,?,?,?,?,?,?);";
            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, uid);
            pst.setString(2, agreVentNombre);
            pst.setString(3, agreVentDesc);
            pst.setString(4, "");
            pst.setString(5, usuario);
            pst.setString(6, fecha);
            pst.setString(7, "");
            pst.setString(8, agreVentServ);

            if (pst.executeUpdate() == 1) {
                System.out.println("Ventanilla Agregada :::" + agreVentNombre);
                StringTokenizer st = new StringTokenizer(agreVentServ);

                PreparedStatement pstz = null;
                String uidz = UUID.randomUUID().toString();
                DateFormat dateFormatz = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                Calendar calz = Calendar.getInstance();
                String fechaz = dateFormatz.format(calz.getTime());
                String consultaz = new String();
                List<String> lstSt = new ArrayList();

                while (st.hasMoreTokens()) {
                    String ser = new String();
                    ser = st.nextToken();
                    lstSt.add(ser);
                }

                for (String strServ : lstSt) {

                    pstz = null;
                    uidz = UUID.randomUUID().toString();
                    dateFormatz = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                    calz = Calendar.getInstance();
                    fechaz = dateFormatz.format(calz.getTime());
                    consultaz = new String();
                    consultaz = "INSERT INTO `turnos`.`servicio_ventanillas` (`id`, `NombreVentanilla`, `NombreServicio`, `UsuarioLastUpdate`, `FechaLastUpdate`) VALUES (?, ?, ?, ?, ?);";
                    pstz = getConexion().prepareStatement(consultaz);

                    pstz.setString(1, uidz);
                    pstz.setString(2, agreVentNombre);
                    pstz.setString(3, strServ);
                    pstz.setString(4, usuario);
                    pstz.setString(5, fechaz);

                    if (pstz.executeUpdate() == 1) {
                        System.out.println("Servicios - Ventanilla Agregados :::" + agreVentNombre + " ::: " + strServ);
                    } else {
                        System.out.println("Servicios - Ventanilla ERROR AGREGAR :::" + agreVentNombre + " ::: " + agreVentServ);
                    }

                }
                return true;
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

        return false;
    }

    //TEST de agregarVentanilla
    /*
     public static void main(String[] args) {
     Consultas co = new Consultas();

     boolean servicio = co.agregarVentanilla("13","Prueba","Contratos Aclaraciones","usertest");
     System.out.println("Ventanilla Agregada :::" + servicio);
     }
     */
    //editarVentanilla 
    public boolean editarVentanilla(String txtventedituser, String txtIdEditV, String txtNombreEditV, String txtDescEditV, String editVentServ) {

        PreparedStatement pst = null;
        PreparedStatement pstz = null;
        PreparedStatement pstc = null;
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Calendar cal = Calendar.getInstance();
        String fecha = dateFormat.format(cal.getTime());
        String delete = new String();

        try {
            String consulta = "UPDATE `turnos`.`ventanillas` SET  `DescVentanilla`= ? ,  `UsuarioLastUpdate`= ? , `FechaLastUpdate`= ? ,  `servicios`= ? WHERE (`idVentanilla`= ? );";
            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, txtDescEditV);
            pst.setString(2, txtventedituser);
            pst.setString(3, fecha);
            pst.setString(4, editVentServ);
            pst.setString(5, txtIdEditV);

            if (pst.executeUpdate() == 1) {
                System.out.println("Ventanilla editada :::" + txtNombreEditV);

                pstc = null;
                String consultac = new String();
                consultac = "delete from servicio_ventanillas where NombreVentanilla=(select NombreVentanilla from ventanillas where idVentanilla= ? );";
                pstc = getConexion().prepareStatement(consultac);
                pstc.setString(1, txtIdEditV);
                if (pstc.executeUpdate() == 1) {
                    System.out.println("Servicios - Ventanilla Eliminados :::" + txtNombreEditV + " ::: ");
                }

                StringTokenizer st = new StringTokenizer(editVentServ);

                String uidz = UUID.randomUUID().toString();
                DateFormat dateFormatz = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                Calendar calz = Calendar.getInstance();
                String fechaz = dateFormatz.format(calz.getTime());
                String consultaz = new String();
                List<String> lstSt = new ArrayList();

                while (st.hasMoreTokens()) {
                    String ser = new String();
                    ser = st.nextToken();
                    lstSt.add(ser);
                }

                for (String strServ : lstSt) {

                    pstz = null;
                    uidz = UUID.randomUUID().toString();
                    dateFormatz = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                    calz = Calendar.getInstance();
                    fechaz = dateFormatz.format(calz.getTime());
                    consultaz = new String();
                    consultaz = "INSERT INTO `turnos`.`servicio_ventanillas` (`id`, `NombreVentanilla`, `NombreServicio`, `UsuarioLastUpdate`, `FechaLastUpdate`) VALUES (?, ?, ?, ?, ?);";
                    pstz = getConexion().prepareStatement(consultaz);

                    pstz.setString(1, uidz);
                    pstz.setString(2, txtNombreEditV);
                    pstz.setString(3, strServ);
                    pstz.setString(4, txtventedituser);
                    pstz.setString(5, fechaz);

                    if (pstz.executeUpdate() == 1) {
                        System.out.println("Servicios - Ventanilla Agregados :::" + txtNombreEditV + " ::: " + strServ);
                    } else {
                        System.out.println("Servicios - Ventanilla ERROR AGREGAR :::" + txtNombreEditV + " ::: " + editVentServ);
                    }

                }
                return true;
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
                if (pstz != null) {
                    pstz.close();
                }
                if (pstc != null) {
                    pstc.close();
                }
            } catch (Exception e) {

                System.err.println("finally Error: " + e);
            }

        }

        return false;
    }

    //TEST de editarVentanilla
    /*
     public static void main(String[] args) {
     Consultas co = new Consultas();
     boolean servicio = co.editarVentanilla("UserLocalTester", "834e4b7e-146a-4535-904a-e83a085c18859", "18", "Prueba", "Aclaraciones");
     System.out.println("Ventanilla Agregada :::" + servicio);
     }*/

 /*
     * TURNOS
     */
    //Obtener consecutivo 
    public String consecutivoServicio(String servicio) {

        PreparedStatement pst = null;
        ResultSet rs = null;
        String consecutivo = new String();
        DateFormat dateFormatz = new SimpleDateFormat("yyyy/MM/dd");
        Calendar calz = Calendar.getInstance();
        String fechaz = dateFormatz.format(calz.getTime());

        try {
            String consulta = "select max(intTurno) as consecutivo from turnos where intServicio = ?  and dtmFechaEspera > ?  AND strTipoTurno !='Reasignado';";
            pst = getConexion().prepareStatement(consulta);
            pst.setString(1, servicio);
            pst.setString(2, fechaz);

            System.out.println("pst :: " + pst);
            rs = pst.executeQuery();

            while (rs.next()) {

                consecutivo = rs.getNString("consecutivo");

            }

            return consecutivo;

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

        return null;
    }
    //TEST de generarTurno

    /*
     public static void main(String[] args) {
     Consultas co = new Consultas();
     String servicio = new String();
     servicio = co.consecutivoServicio("BotÃ³n");
     System.out.println("Servicio :::" + servicio );
     }*/
    //GENERAR UN NUEVO TURNO
    public String generarTurno(String servicio) {
        String turno = new String();

        //Identificar el Servicio para generar turno
        Servicio servObj = new Servicio();
        servObj = obtenerServicio(servicio);

        String prefijoTurno = servObj.getPrefijo();

        String postfijoTurno = new String();
        //Buscar el último valor consecutivo al turno correspondiente del servicio seleccionado
        Consultas cot = new Consultas();
        //System.out.println("cons ::: " + servObj.getDescripcionServicio());
        String cons = cot.consecutivoServicio(servObj.getDescripcionServicio());
        //System.out.println("cons ::: " + cons);

        if (null != cons) {
            if (cons.length() < 3) {
                Integer c = Integer.parseInt(cons);
                Formatter fmt = new Formatter();
                fmt.format("%03d", c);
                turno = prefijoTurno + "-" + fmt;
            } else {

                Integer postfijo = Integer.parseInt(cons.substring(cons.length() - 3, cons.length()));
                postfijo++;
                Formatter fmt = new Formatter();
                fmt.format("%03d", postfijo);
                turno = prefijoTurno + "-" + fmt;
            }

        } else {

            turno = prefijoTurno + "-" + "001";
        }

        return turno;
    }

    //TEST de generarTurno
//     public static void main(String[] args) {
//     Consultas col = new Consultas();
//     String servicio = new String();
//     servicio = col.generarTurno("df32934b-d465-46ef-b309-30253b06bfda");
//     System.out.println("Servicio :::" + servicio);
//     }
    //Guardar turno 
    //(String idTurno, String intTurno, String intVentanilla, String intServicio, String strCliente, String strEstatusTurno, String strTipoTurno, String dtmFechaEspera, String dtmFechaAtencion, String intOficinadeServicios, String dtmFechaTermino) {
    public boolean guardarNuevoTurno(String intTurno, String intServicio, String intOficinadeServicios, String valPreferencial) {

        PreparedStatement pst = null;
        PreparedStatement pst1 = null;
        ResultSet rs = null;
        String consecutivo = new String();
        UUID uid = UUID.randomUUID();
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Calendar cal = Calendar.getInstance();
        System.out.println(dateFormat.format(cal.getTime()));
        String fecha = dateFormat.format(cal.getTime());

        try {
            String consulta = "INSERT INTO `turnos`.`turnos` (`idTurno`, `intTurno`, `intVentanilla`, `intServicio`, `strCliente`, `strEstatusTurno`, `strTipoTurno`, `dtmFechaEspera`, `dtmFechaAtencion`, `intOficinadeServicios`, `dtmFechaTermino`,`enviado`, `valPreferencial`) VALUES \n"
                    + "(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?,?);";
            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, uid.toString());
            pst.setString(2, intTurno);
            pst.setString(3, " ");
            pst.setString(4, intServicio);
            pst.setString(5, "Local");
            pst.setString(6, "Espera");
            pst.setString(7, "Normal");
            pst.setString(8, fecha);
            pst.setString(9, "");
            pst.setString(10, intOficinadeServicios);
            pst.setString(11, "");
            pst.setString(12, "0");
            pst.setString(13, valPreferencial);

            System.out.println("pst :: " + pst);
            if (pst.executeUpdate() == 1) {
                System.out.println("Turno insertado:::" + intServicio + " / " + intTurno);

                return true;

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

        return false;
    }
    //TEST de guardarNuevoTurno
/*
     public static void main(String[] args) {
     Consultas co = new Consultas();

     boolean servicio = co.guardarNuevoTurno("001", "Contratos", "1");
     System.out.println("Servicio :::" + servicio);
     }
     */

    //Obtener consulServiciosVentanilla 
    public List<String> consulServiciosVentanilla(String NumVentanilla) {

        PreparedStatement pst = null;
        ResultSet rs = null;
        List<String> lstServ = new ArrayList<String>();

        try {
            String consulta = "Select * from servicio_ventanillas where NombreVentanilla = ? ;";
            pst = getConexion().prepareStatement(consulta);
            pst.setString(1, NumVentanilla);

            rs = pst.executeQuery();

            while (rs.next()) {
                String serv = new String();
                serv = rs.getString("NombreServicio");
                lstServ.add(serv);
            }

            return lstServ;

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
        return lstServ;
    }
    //TEST de consulServiciosVentanilla

    /*
     public static void main(String[] args) {
     Consultas co = new Consultas();
     List<String> lstServ = new ArrayList<String>();
     lstServ = co.consulServiciosVentanilla("1");
     System.out.println("Nombre de oficina :::" + lstServ.size()); 
     }
     */
    ///* existeturnopref
    public boolean existeturnopref(List<String> lstServ, String intVent, String nombreUser, String usuario) {

        PreparedStatement pst = null;
        ResultSet rs = null;
        String param = new String();
        String lstParam = new String();
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
        Calendar cal = Calendar.getInstance();
        String fechaX = new String();
        fechaX = dateFormat.format(cal.getTime());
        fechaX = fechaX + " 00:00:01";
        Turno turno = new Turno();
        if (lstServ.size() == 1) {
            for (String s : lstServ) {
                param = new String();
                param = s;
                lstParam = param;
            }
            //System.out.println("Servicios 1::: " + lstParam);
        } else {
            if (lstServ.isEmpty()) {
                System.out.println("::: La lista de Servicios está vacia ::: ");

            }
            if (lstServ.size() > 1) {
                for (String s : lstServ) {

                    param = param + s + "','";
                    lstParam = param;
                }
                lstParam = lstParam.substring(0, lstParam.length() - 3);
            }
            System.out.println("Servicios <1::: " + lstParam);
        }

        try {
            String consulta = "select count(valPreferencial) as valPreferencial from turnos where intServicio IN('" + lstParam + "') AND valPreferencial='true' AND num_atenciones<='3' AND strEstatusTurno IN('Espera') AND dtmFechaEspera = (select MIN(dtmFechaEspera) from turnos WHERE dtmFechaEspera > '" + fechaX + "' AND strEstatusTurno IN('Espera') AND intServicio IN('" + lstParam + "') AND valPreferencial='true' ) ;";
            pst = getConexion().prepareStatement(consulta);

            System.out.println("script preferencia true--> ::: " + pst);
            rs = pst.executeQuery();
            while (rs.next()) {
                if (rs.getString("valPreferencial").equalsIgnoreCase("0")) {
                    System.out.println("No existe turno preferencial:::");
                    return false;
                } else {
                    System.out.println("Existe turno preferencial se avanza primero:::");
                    return true;
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

        return false;
    }

    //Obtener consulSigTurnoVent 
    public Turno consulSigTurnoVent(List<String> lstServ, String intVent, String nombreUser, String usuario, boolean preferencial) {

        PreparedStatement pst = null;
        PreparedStatement pst2 = null;
        ResultSet rs = null;
        String param = new String();
        String lstParam = new String();
        Turno turno = new Turno();
        //System.out.println("lstServ size ::: " + lstServ.size());
        if (lstServ.size() == 1) {
            for (String s : lstServ) {
                param = new String();
                param = s;
                lstParam = param;
            }
            //System.out.println("Servicios 1::: " + lstParam);
        } else {
            if (lstServ.isEmpty()) {
                System.out.println("::: La lista de Servicios está vacia ::: ");
                return turno;
            }
            if (lstServ.size() > 1) {
                for (String s : lstServ) {

                    param = param + s + "','";
                    lstParam = param;
                }
                lstParam = lstParam.substring(0, lstParam.length() - 3);
            }
            System.out.println("Servicios <1::: " + lstParam);
        }

        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
        Calendar cal = Calendar.getInstance();
        String fechaX = new String();
        fechaX = dateFormat.format(cal.getTime());
        fechaX = fechaX + " 00:00:01";
        //System.out.println("fechaX ::: " + fechaX);
        try {
            String consulta = new String();
            if (preferencial) {
                System.out.println("Busqueda de siguiente turno preferencial");
                consulta = "select * from turnos where intServicio IN('" + lstParam + "') AND valPreferencial='true' AND num_atenciones<='3' AND strEstatusTurno IN('Espera') AND dtmFechaEspera = (select MIN(dtmFechaEspera) from turnos WHERE dtmFechaEspera > '" + fechaX + "' AND strEstatusTurno IN('Espera') AND intServicio IN('" + lstParam + "') AND valPreferencial='true' ) ; ";

            } else {
                System.out.println("Busqueda de siguiente turno normal sin prefrencias asignadas");
                consulta = "select * from turnos where intServicio IN('" + lstParam + "') AND num_atenciones<='3' AND strEstatusTurno IN('Espera') AND dtmFechaEspera = (select MIN(dtmFechaEspera) from turnos WHERE dtmFechaEspera > '" + fechaX + "' AND strEstatusTurno IN('Espera') AND intServicio IN('" + lstParam + "') ) ; ";

            }

            pst = getConexion().prepareStatement(consulta);

            rs = pst.executeQuery();
            System.out.println("pst::" + pst);
            while (rs.next()) {
                turno = new Turno();

                turno.setIdTurno(rs.getString("idTurno"));
                turno.setIntTurno(rs.getString("intTurno"));
                turno.setIntVentanilla(rs.getString("intVentanilla"));
                turno.setIntServicio(rs.getString("intServicio"));
                turno.setStrCliente(rs.getString("strCliente"));
                turno.setStrEstatusTurno(rs.getString("strEstatusTurno"));
                turno.setStrTipoTurno(rs.getString("strTipoTurno"));
                turno.setDtmFechaEspera(rs.getString("dtmFechaEspera"));
                turno.setDtmFechaAtencion(rs.getString("dtmFechaAtencion"));
                turno.setIntOficinadeServicios(rs.getString("intOficinadeServicios"));
                turno.setDtmFechaTermino(rs.getString("dtmFechaTermino"));
                turno.setDtmFechaTermino(rs.getString("enviado"));
                turno.setDtmFechaTermino(rs.getString("dt_enviado"));
                turno.setDtmFechaTermino(rs.getString("num_atenciones"));
                turno.setUsuario1(rs.getString("strIdUserAttending"));
                turno.setValPreferencial(rs.getString("valPreferencial"));

            }

            try {
                PreparedStatement psto = null;
                ResultSet rso = null;
                DateFormat dateFt = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                Calendar cl = Calendar.getInstance();
                String fechaA = dateFt.format(cl.getTime());
                String consultaUpdate = "UPDATE `turnos`.`turnos` SET `strIdUserAttending`='" + usuario + "', `strUserAttending`='" + nombreUser + "',`strEstatusTurno`='Atendiendo', `dtmFechaAtencion`='" + fechaA + "', intVentanilla='" + intVent + " ' WHERE (`idTurno`='" + turno.getIdTurno() + "'); ";
                psto = getConexion().prepareStatement(consultaUpdate);

                if (psto.executeUpdate() == 1) {
                    //System.out.println("Turno " + turno.getIdTurno() + " actualizado a Atendiendo :::");

                    String consultaUpd = "UPDATE `turnos`.`ventanillas` SET `LastTurnAtended`='" + turno.getIdTurno() + "' WHERE (`NombreVentanilla`='" + intVent + "');";
                    psto = getConexion().prepareStatement(consultaUpd);
                    //System.out.println("script ::: "+psto);
                    if (psto.executeUpdate() == 1) {
                        System.out.println("Turno " + turno.getIdTurno().toString() + " referenciado en Ventanilla LastTurnAtended  :::" + intVent);
                    }

                }

                return turno;
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
        return turno;
    }
    //TEST de consulServiciosVentanilla
/*
     public static void main(String[] args) {
     Consultas co = new Consultas();
     List<String> lstServ = new ArrayList<String>();
     lstServ.add("Aclaraciones");
     Turno tur = new Turno();
     tur = co.consulSigTurnoVent(lstServ);
     System.out.println("Turno :::" + tur.getIntTurno());
     }
     */

    //Terminar turno 
    //(String idTurno, String intTurno, String intVentanilla, String intServicio, String strCliente, String strEstatusTurno, String strTipoTurno, String dtmFechaEspera, String dtmFechaAtencion, String intOficinadeServicios, String dtmFechaTermino) {
    public boolean terminarTurno(String intVentanilla, String statusatencionSelect, String tiposervicioSelect) {

        PreparedStatement pst = null;
        ResultSet rs = null;
        DateFormat dateFt = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Calendar cl = Calendar.getInstance();
        String fechaT = dateFt.format(cl.getTime());
        try {
            String consulta = "UPDATE `turnos`.`turnos` SET `strTipoServicio`='" + tiposervicioSelect + "', `strEstatusAtencion`='" + statusatencionSelect + "', dtmFechaTermino='" + fechaT + "', `strEstatusTurno`='Terminado' WHERE `idTurno`=(select LastTurnAtended from ventanillas where NombreVentanilla='" + intVentanilla + "');";
            pst = getConexion().prepareStatement(consulta);

            if (pst.executeUpdate() == 1) {
                System.out.println("Turno Terminado:::");

                return true;
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

        return false;
    }
    //TEST de terminarTurno
/*
     public static void main(String[] args) {
     Consultas co = new Consultas();

     boolean servicio = co.terminarTurno("1");
     System.out.println("Terminar Turno :::" + servicio);
     }*/

    //Obtener obtenerTurnoxId 
    public Turno obtenerTurnoxId(String intVenta) {

        PreparedStatement pst = null;
        ResultSet rs = null;
        Turno turno = new Turno();

        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Calendar cal = Calendar.getInstance();
        String fechaX = new String();
        fechaX = dateFormat.format(cal.getTime());

        try {
            String consulta = "select * from turnos where idTurno = (select LastTurnAtended from ventanillas where NombreVentanilla='" + intVenta + "');";
            pst = getConexion().prepareStatement(consulta);

            //System.out.println("script ::: "+pst);
            rs = pst.executeQuery();

            while (rs.next()) {
                turno = new Turno();

                turno.setIdTurno(rs.getString("idTurno"));
                turno.setIntTurno(rs.getString("intTurno"));
                turno.setIntVentanilla(rs.getString("intVentanilla"));
                turno.setIntServicio(rs.getString("intServicio"));
                turno.setStrCliente(rs.getString("strCliente"));
                turno.setStrEstatusTurno(rs.getString("strEstatusTurno"));
                turno.setStrTipoTurno(rs.getString("strTipoTurno"));
                turno.setDtmFechaEspera(rs.getString("dtmFechaEspera"));
                turno.setDtmFechaAtencion(rs.getString("dtmFechaAtencion"));
                turno.setIntOficinadeServicios(rs.getString("intOficinadeServicios"));
                turno.setDtmFechaTermino(rs.getString("dtmFechaTermino"));

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
        return turno;
    }
    //TEST de obtenerTurnoxId
/*
     public static void main(String[] args) {
     Consultas co = new Consultas();
     Turno tur = new Turno();
     tur = co.obtenerTurnoxId("1");
     System.out.println("Turno :::" + tur.getIntTurno());
     }
     */

    //Obtener obtenerTurnoxId 
    public ProxTurnos obtenerProxTurnos() {

        PreparedStatement pst = null;
        ResultSet rs = null;
        ProxTurnos turno = new ProxTurnos();
        List<String> lstTurno = new ArrayList<String>();

        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
        Calendar cal = Calendar.getInstance();
        String fechaX = new String();
        fechaX = dateFormat.format(cal.getTime());
        fechaX = fechaX + " 00:00:01";

        try {
            String consulta = "select intTurno from turnos WHERE dtmFechaEspera > '" + fechaX + "' AND strEstatusTurno='Espera' ORDER BY dtmFechaEspera ASC LIMIT 4;";
            pst = getConexion().prepareStatement(consulta);

            //System.out.println("script ::: "+pst);
            rs = pst.executeQuery();

            while (rs.next()) {
                String t = new String();

                t = rs.getString("intTurno");

                lstTurno.add(t);
            }

            turno.setTur1(lstTurno.get(0));
            turno.setTur2(lstTurno.get(1));
            turno.setTur3(lstTurno.get(2));
            turno.setTur4(lstTurno.get(3));

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
        return turno;
    }
    //TEST de obtenerProxTurnos

    /*
     public static void main(String[] args) {
     Consultas co = new Consultas();
     ProxTurnos tur = new ProxTurnos();
     tur = co.obtenerProxTurnos();
     System.out.println("ProxTurnos 1 :::" + tur.getTur1());
     System.out.println("ProxTurnos 2 :::" + tur.getTur2());
     System.out.println("ProxTurnos 3 :::" + tur.getTur3());
     System.out.println("ProxTurnos 4 :::" + tur.getTur4());

     }*/
    //Obtener obtenerUltimosTurnos 
    public List<UltTurnos> obtenerUltimosTurnos() {

        PreparedStatement pst = null;
        ResultSet rs = null;
        UltTurnos turno = new UltTurnos();
        List<UltTurnos> lstTurno = new ArrayList<UltTurnos>();

        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
        Calendar cal = Calendar.getInstance();
        String fechaX = new String();
        fechaX = dateFormat.format(cal.getTime());
        fechaX = fechaX + " 00:00:01";

        try {

            String consulta = "select intTurno, intVentanilla from turnos WHERE dtmFechaAtencion > '" + fechaX + "' AND strEstatusTurno='Atendiendo' ORDER BY dtmFechaEspera DESC LIMIT 5";
            pst = getConexion().prepareStatement(consulta);

            //System.out.println("script ::: "+pst);
            rs = pst.executeQuery();

            while (rs.next()) {
                UltTurnos t = new UltTurnos();

                t.setTur1(rs.getString("intTurno"));
                t.setV1(rs.getString("intVentanilla"));

                lstTurno.add(t);
            }

            System.out.println("lst::: " + lstTurno);
            UltTurnos ttt = new UltTurnos();
            ttt.setTur1(" ");
            ttt.setV1(" ");
            System.out.println("lstTurno.size " + lstTurno.size());
            if (lstTurno.isEmpty()) {
                lstTurno.add(ttt);
                lstTurno.add(ttt);
                lstTurno.add(ttt);
                lstTurno.add(ttt);
                lstTurno.add(ttt);
            }
            if (1 == lstTurno.size()) {
                lstTurno.add(ttt);
                lstTurno.add(ttt);
                lstTurno.add(ttt);
                lstTurno.add(ttt);
            }
            if (2 == lstTurno.size()) {
                lstTurno.add(ttt);
                lstTurno.add(ttt);
                lstTurno.add(ttt);
            }
            if (3 == lstTurno.size()) {
                lstTurno.add(ttt);
                lstTurno.add(ttt);
            }
            if (4 == lstTurno.size()) {
                lstTurno.add(ttt);
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
        return lstTurno;
    }
    //TEST de obtenerProxTurnos

    /*
     public static void main(String[] args) {
     Consultas co = new Consultas();
     List<UltTurnos> lstTurno = new ArrayList<UltTurnos>();
     lstTurno = co.obtenerUltimosTurnos();
     for(UltTurnos ult :lstTurno){
     System.out.println("Turno  :::" + ult.getTur1());
     System.out.println("Ventanilla  :::" + ult.getV1());
     }
     }*/
    //Terminar turno 
    //(String idTurno, String intTurno, String intVentanilla, String intServicio, String strCliente, String strEstatusTurno, String strTipoTurno, String dtmFechaEspera, String dtmFechaAtencion, String intOficinadeServicios, String dtmFechaTermino) {
    public boolean reasignarTurno(Turno turno, String serv) {

        PreparedStatement pst = null;
        ResultSet rs = null;
        DateFormat dateFt = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Calendar cl = Calendar.getInstance();
        String fechaT = dateFt.format(cl.getTime());
        UUID uid = UUID.randomUUID();
        try {
            String consulta = "INSERT INTO `turnos`.`turnos` (`idTurno`, `intTurno`, `intVentanilla`, `intServicio`, `strCliente`, `strEstatusTurno`, `strTipoTurno`, `dtmFechaEspera`, `dtmFechaAtencion`, `intOficinadeServicios`, `dtmFechaTermino`) VALUES \n"
                    + "(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, uid.toString());
            pst.setString(2, turno.getIntTurno());
            pst.setString(3, " ");
            pst.setString(4, serv);
            pst.setString(5, "Local");
            pst.setString(6, "Espera");
            pst.setString(7, "Reasignado");
            pst.setString(8, turno.getDtmFechaEspera());
            pst.setString(9, "");
            pst.setString(10, turno.getIntOficinadeServicios());
            pst.setString(11, "");

            if (pst.executeUpdate() == 1) {
                System.out.println("Turno resignado:::" + serv + "" + turno.getIntTurno() + " En Espera");
                return true;
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

        return false;
    }
    //TEST de reasignarTurno
/*
     public static void main(String[] args) {
     Consultas co = new Consultas();
     Turno tu = new Turno();
     tu.setIntTurno("AA-007");
     tu.setDtmFechaAtencion("2020/03/04 11:35:55");
     tu.setIntOficinadeServicios("1");
     boolean servicio = co.reasignarTurno(tu,"PruebaReasigna");
     System.out.println("reasignarTurno :::" + servicio);
     }
     */

    //Obtener all Turnos
    public List<Turno> allTurnosCentral() {

        PreparedStatement pst = null;
        ResultSet rs = null;
        Turno turno;
        List<Turno> lstTur = new ArrayList<>();

        try {
            String consulta = "select * from turnos where (dtmFechaEspera >= (select dt_tblturno_last from oficinalocal));";
            pst = getConexion().prepareStatement(consulta);

            rs = pst.executeQuery();

            while (rs.next()) {
                turno = new Turno();
                turno.setIdTurno(rs.getString("idTurno"));
                turno.setIntTurno(rs.getString("intTurno"));
                turno.setIntVentanilla(rs.getString("intVentanilla"));
                turno.setIntServicio(rs.getString("intServicio"));
                turno.setStrCliente(rs.getString("strCliente"));
                turno.setStrEstatusTurno(rs.getString("strEstatusTurno"));
                turno.setStrTipoTurno(rs.getString("strTipoTurno"));
                turno.setDtmFechaEspera(rs.getString("dtmFechaEspera"));
                turno.setDtmFechaAtencion(rs.getString("dtmFechaAtencion"));
                turno.setIntOficinadeServicios(rs.getString("intOficinadeServicios"));
                turno.setDtmFechaTermino(rs.getString("dtmFechaTermino"));

                lstTur.add(turno);

            }

            return lstTur;

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
        return lstTur;
    }
    //TEST de allTurnosCentral

    /*
     public static void main(String[] args) {
     Consultas co = new Consultas();
     List<Turno> lstUsu = new ArrayList();
     lstUsu = co.allTurnos();
     System.out.println("Lista de turnos :::" + lstUsu.size()); 
     }
     */
    //actualizarturnoenviado turno 
    public boolean actualizarturnoenviado(String turno) {

        PreparedStatement pst = null;
        DateFormat dateFt = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Calendar cl = Calendar.getInstance();
        String fechaT = dateFt.format(cl.getTime());
        try {
            String consulta = "UPDATE `turnos`.`turnos` SET  `enviado`='1', `dt_enviado`=? WHERE `idTurno`=?;";
            pst = getConexion().prepareStatement(consulta);
            pst.setString(1, fechaT);
            pst.setString(2, turno);

            if (pst.executeUpdate() == 1) {
                System.out.println("Turno actualizado local a enviado:::" + turno);
                return true;
            } else {
                System.out.println("Turno no actualizado local a enviado:::" + turno);
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

        return false;
    }
    //TEST de actualizarturnoenviado

    //Obtener all Turnos central
    public List<Turno> allTurnosCentralL() {

        PreparedStatement pst = null;
        ResultSet rs = null;
        Turno turno;
        List<Turno> lstTur = new ArrayList<>();

        try {
            String consulta = "select * from turnos where enviado = '0' and strEstatusTurno in('Terminado','Cancelado');";
            pst = getConexion().prepareStatement(consulta);

            rs = pst.executeQuery();

            while (rs.next()) {
                turno = new Turno();
                turno.setIdTurno(rs.getString("idTurno"));
                turno.setIntTurno(rs.getString("intTurno"));
                turno.setIntVentanilla(rs.getString("intVentanilla"));
                turno.setIntServicio(rs.getString("intServicio"));
                turno.setStrCliente(rs.getString("strCliente"));
                turno.setStrEstatusTurno(rs.getString("strEstatusTurno"));
                turno.setStrTipoTurno(rs.getString("strTipoTurno"));
                turno.setDtmFechaEspera(rs.getString("dtmFechaEspera"));
                turno.setDtmFechaAtencion(rs.getString("dtmFechaAtencion"));
                turno.setIntOficinadeServicios(rs.getString("intOficinadeServicios"));
                turno.setDtmFechaTermino(rs.getString("dtmFechaTermino"));
                turno.setStrIdUserAttending(rs.getString("strIdUserAttending"));
                turno.setStrUserAttending(rs.getString("strUserAttending"));
                turno.setStrEstatusAtencion(rs.getString("strEstatusAtencion"));
                turno.setValPreferencial(rs.getString("valPreferencial"));
                turno.setStrTipoServicio(rs.getString("strTipoServicio"));
                lstTur.add(turno);

            }

            return lstTur;

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
        return lstTur;
    }

    //Obtener obtenerFchLastEnvioCentral 
    public String obtenerFchLastEnvioCentral() {

        PreparedStatement pst = null;
        ResultSet rs = null;
        String fecha = null;

        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Calendar cal = Calendar.getInstance();
        String fechaX = new String();
        fechaX = dateFormat.format(cal.getTime());

        try {
            String consulta = "select dt_tblturno_last from oficinalocal";
            pst = getConexion().prepareStatement(consulta);

            //System.out.println("script ::: "+pst);
            rs = pst.executeQuery();

            while (rs.next()) {
                fecha = new String();

                fecha = rs.getString("dt_tblturno_last");

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
        return fecha;
    }
    //TEST de obtenerFchLastEnvioCentral
/*
     public static void main(String[] args) {
     Consultas co = new Consultas();
     String f = new String();
     f = co.obtenerFchLastEnvioCentral();
     System.out.println("Fecha :::" + f);
     }
     */

    //actualizarfechaEnvioCentral
    public boolean actualizarfechaEnvioCentral() {

        PreparedStatement pst = null;

        DateFormat dateFt = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Calendar cl = Calendar.getInstance();
        String fechaT = dateFt.format(cl.getTime());

        try {
            String consulta = "UPDATE `turnos`.`oficinalocal` SET `dt_tblturno_last`= ?;";
            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, fechaT);

            if (pst.executeUpdate() == 1) {
                System.out.println("Fecha actualizada:::" + fechaT);
                return true;
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

        return false;
    }

    /*
     *consultarTurno
     */
    //consultarTurno
    public Turno consultarTurno(String idTurno) {

        PreparedStatement pst = null;
        ResultSet rs = null;
        Turno turno = new Turno();

        try {
            String consulta = "select * from turnos where idTurno='" + idTurno + "'";

            pst = getConexion().prepareStatement(consulta);

            System.out.println("pst:::" + pst);
            rs = pst.executeQuery();

            while (rs.next()) {
                turno = new Turno();
                turno.setIdTurno(rs.getString("idTurno"));
                turno.setIntTurno(rs.getString("intTurno"));
                turno.setIntVentanilla(rs.getString("intVentanilla"));
                turno.setIntServicio(rs.getString("intServicio"));
                turno.setStrCliente(rs.getString("strCliente"));
                turno.setStrEstatusTurno(rs.getString("strEstatusTurno"));
                turno.setStrTipoTurno(rs.getString("strTipoTurno"));
                turno.setDtmFechaEspera(rs.getString("dtmFechaEspera"));
                turno.setDtmFechaAtencion(rs.getString("dtmFechaAtencion"));
                turno.setIntOficinadeServicios(rs.getString("intOficinadeServicios"));
                turno.setDtmFechaTermino(rs.getString("dtmFechaTermino"));
                turno.setNum_atenciones(rs.getString("num_atenciones"));

            }

            return turno;

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
        return null;
    }

    /*
     *cancelarTurno
     */
    //cancelarTurno
    public boolean cancelarTurno(Turno turno) {

        PreparedStatement pst = null;

        DateFormat dateFt = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Calendar cl = Calendar.getInstance();
        String fechaT = dateFt.format(cl.getTime());
        String na = turno.getNum_atenciones();

        if (na.contains("0")) {

            try {

                String num_ate = "1";
                String consulta = "UPDATE `turnos`.`turnos` SET `intVentanilla`=' ', `strEstatusTurno`='Espera', `dtmFechaEspera`=?, `num_atenciones`=? WHERE (`idTurno`=?);";
                pst = getConexion().prepareStatement(consulta);

                pst.setString(1, fechaT);
                pst.setString(2, num_ate);
                pst.setString(3, turno.getIdTurno());

                if (pst.executeUpdate() == 1) {
                    System.out.println("Fecha actualizada:::" + fechaT);
                    return true;
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

        } else if (na.contains("1")) {

            try {

                String num_ate = "2";
                String consulta = "UPDATE `turnos`.`turnos` SET `intVentanilla`=' ', `strEstatusTurno`='Espera', `dtmFechaEspera`=?, `num_atenciones`=? WHERE (`idTurno`=?);";
                pst = getConexion().prepareStatement(consulta);

                pst.setString(1, fechaT);
                pst.setString(2, num_ate);
                pst.setString(3, turno.getIdTurno());

                if (pst.executeUpdate() == 1) {
                    return true;
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

        } else if (na.contains("2")) {

            try {

                String num_ate = "3";
                String consulta = "UPDATE `turnos`.`turnos` SET `intVentanilla`=' ', `strEstatusTurno`='Espera', `dtmFechaEspera`=?, `num_atenciones`=? WHERE (`idTurno`=?);";
                pst = getConexion().prepareStatement(consulta);

                pst.setString(1, fechaT);
                pst.setString(2, num_ate);
                pst.setString(3, turno.getIdTurno());

                if (pst.executeUpdate() == 1) {
                    return true;
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

        } else if (na.contains("3")) {

            try {
                String consulta = "UPDATE `turnos`.`turnos` SET  `strEstatusTurno`='Cancelado', `dtmFechaTermino`=?  WHERE (`idTurno`=?);";
                pst = getConexion().prepareStatement(consulta);

                pst.setString(1, fechaT);
                pst.setString(2, turno.getIdTurno());

                if (pst.executeUpdate() == 1) {

                    return true;
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

    //editarPoster 
    public boolean editarPoster(String TxtImgNameSelected) {

        PreparedStatement pst = null;

        try {
            String consulta = "UPDATE `turnos`.`oficinalocal` SET  `poster`= ? ;";
            pst = getConexion().prepareStatement(consulta);
            pst.setString(1, TxtImgNameSelected);

            System.out.println("pst UPDATE ::: " + pst);

            if (pst.executeUpdate() == 1) {
                System.out.println("Imagen Editada :::" + TxtImgNameSelected);

                return true;
            } else {
                System.out.println("Imagen No Editada :::" + TxtImgNameSelected);
                return false;
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

        return false;
    }

    //TEST de editarPoster
    /*
     public static void main(String[] args) {
     Consultas co = new Consultas();
     boolean servicio = co.editarVideo("Prueba");
     System.out.println("Video Actualizado :::" + servicio);
     }
     */
    //Consultar turnos por atender de ventanilla
    public String turnosfaltantesventanilla(String ventanilla) {

        PreparedStatement pst = null;
        ResultSet rs = null;
        String servicios = new String();

        try {
            String consulta = "select servicios from ventanillas where NombreVentanilla='" + ventanilla + "'";

            pst = getConexion().prepareStatement(consulta);

            System.out.println("pst:::" + pst);
            rs = pst.executeQuery();

            while (rs.next()) {
                servicios = rs.getString("servicios");
                // System.out.println("servicios :::"+rs.getString("servicios"));
            }
        } catch (Exception ex) {
            System.out.println("Error :: " + ex);
        }

        servicios = servicios.replace(" ", "','");
        //System.out.println(":::::::: " + servicios);
        String num = new String();
        if (servicios.length() > 3) {
            servicios = "'" + servicios.substring(0, servicios.length() - 2);
            DateFormat dateFt = new SimpleDateFormat("yyyy/MM/dd");
            Calendar cl = Calendar.getInstance();
            String fechaT = dateFt.format(cl.getTime());
            System.out.println("FechaT: " + fechaT + " 01:00:00");

            try {
                String consulta = "select count(intTurno) as numero from turnos where strEstatusTurno=\"Espera\" and dtmFechaEspera>'" + fechaT + " 01:00:00' and intServicio in(" + servicios + ")";

                pst = getConexion().prepareStatement(consulta);

                System.out.println("pst:::" + pst);
                rs = pst.executeQuery();

                while (rs.next()) {
                    num = rs.getString("numero");
                    // System.out.println("num :::"+rs.getString("numero"));
                }
            } catch (Exception ex) {
                System.out.println("Error :: " + ex);
            }
        } else {
            num = "0";
        }
        System.out.println("num:: " + num);
        return num;
    }

    //TEST de editarPoster
    public static void main(String[] args) {
        Consultas co = new Consultas();
        String servicio = co.turnosfaltantesventanilla("01");
        System.out.println("servicio :::: " + servicio);
    }

    //Lista de Turnos atendidos por ventanilla
    //generarreporteatendidos
    public ArrayList<RepAtendidos> generarreporteatendidos(String dtInicio, String dtFin) {
        ArrayList<RepAtendidos> lstatendidos = new ArrayList<>();

        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            String consulta = "select valPreferencial as valPreferencial, dtmFechaEspera as fespera,strEstatusAtencion as estatus, intOficinadeServicios as idOficina, intVentanilla as ventanilla,strIdUserAttending as idatiende, strUserAttending as atiende, intTurno as turno, intServicio as servicio, dtmFechaAtencion as finicio, dtmFechaTermino as ffinal from turnos where dtmFechaAtencion>='" + dtInicio + "' and dtmFechaTermino<='" + dtFin + "' and strEstatusTurno='Terminado' ORDER BY intVentanilla;";

            pst = getConexion().prepareStatement(consulta);

            System.out.println("pst:::" + pst);
            rs = pst.executeQuery();

            while (rs.next()) {
                RepAtendidos ra = new RepAtendidos();
                ra.setVentanilla(rs.getString("ventanilla"));
                ra.setTurno(rs.getString("turno"));
                ra.setServicio(rs.getString("servicio"));
                ra.setFinicio(rs.getString("finicio"));
                ra.setFfinal(rs.getString("ffinal"));
                ra.setFespera(rs.getString("fespera"));
                ra.setAtiende(rs.getString("atiende"));
                ra.setIdatiende(rs.getString("idatiende"));
                ra.setIdOficina(rs.getString("idOficina"));
                ra.setEstatus(rs.getString("estatus"));
                ra.setPreferencial(rs.getString("valPreferencial"));
                lstatendidos.add(ra);
            }
        } catch (Exception ex) {
            System.out.println("Error :: " + ex);
        }

        return lstatendidos;
    }

    //
    //Lista con tiempos de atencion por servicios
    //generarreportetservicios
    public ArrayList<RepTiempoServicio> generarreportetservicios(String dtini, String dtfin) {
        ArrayList<RepTiempoServicio> lstatservicios = new ArrayList<>();

        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            String consulta = "select  valPreferencial as valPreferencial,dtmFechaAtencion as fatencion, strEstatusAtencion as estatus, intOficinadeServicios as idOficina, strIdUserAttending as idatiende ,  strUserAttending as atiende, intServicio as servicio, dtmFechaEspera as tespera, dtmFechaAtencion as tatencion, dtmFechaTermino as ttermino from turnos where dtmFechaAtencion>='" + dtini + "' and dtmFechaTermino<='" + dtfin + "' and strEstatusTurno='Terminado' ORDER BY intServicio;";

            pst = getConexion().prepareStatement(consulta);

            System.out.println("pst:::" + pst);
            rs = pst.executeQuery();

            while (rs.next()) {
                RepTiempoServicio tserv = new RepTiempoServicio();
                tserv.setServicio(rs.getString("servicio"));
                tserv.setTespera(rs.getString("tespera"));
                tserv.setTatencion(rs.getString("tatencion"));
                tserv.setTtermino(rs.getString("ttermino"));
                tserv.setAtiende(rs.getString("atiende"));
                tserv.setIdatiende(rs.getString("idatiende"));
                tserv.setIdOficina(rs.getString("idOficina"));
                tserv.setEstatus(rs.getString("estatus"));
                tserv.setFatencion(rs.getString("fatencion"));
                tserv.setPreferencial(rs.getString("valPreferencial"));
                System.out.println("fatencion:: " + tserv.getFatencion());

                lstatservicios.add(tserv);
            }
        } catch (Exception ex) {
            System.out.println("Error :: " + ex);
        }

        return lstatservicios;
    }

    //
    //
    //Lista con tiempos de atencion por turnos
    //generarreportetticket
    public ArrayList<RepTiempoTicket> generarreportetticket(String dtini, String dtfin) {
        ArrayList<RepTiempoTicket> lstatturnos = new ArrayList<>();

        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            String consulta = "select valPreferencial as valPreferencial,dtmFechaAtencion as fatencion, strEstatusAtencion as estatus, intOficinadeServicios as idOficina, strIdUserAttending as idatiende ,  strUserAttending as atiende, intTurno as turno, dtmFechaEspera as fespera, dtmFechaAtencion as fatencion, dtmFechaTermino as ftermino, intVentanilla as ventanilla, strTipoTurno as reasignado, strEstatusTurno as cancelado  from turnos where dtmFechaAtencion>='" + dtini + "' and dtmFechaTermino<='" + dtfin + "' and strEstatusTurno in('Terminado','Cancelado') ORDER BY dtmFechaEspera;";

            pst = getConexion().prepareStatement(consulta);

            System.out.println("pst:::" + pst);
            rs = pst.executeQuery();

            while (rs.next()) {
                RepTiempoTicket tticket = new RepTiempoTicket();
                tticket.setTurno(rs.getString("turno"));
                tticket.setFespera(rs.getString("fespera"));
                tticket.setFatencion(rs.getString("fatencion"));
                tticket.setFtermino(rs.getString("ftermino"));
                tticket.setVentanilla(rs.getString("ventanilla"));
                tticket.setReasignado(rs.getString("reasignado"));
                tticket.setCancelado(rs.getString("cancelado"));
                tticket.setAtiende(rs.getString("atiende"));
                tticket.setIdatiende(rs.getString("idatiende"));
                tticket.setIdOficina(rs.getString("idOficina"));
                tticket.setEstatus(rs.getString("estatus"));
                tticket.setPreferencial(rs.getString("valPreferencial"));
                lstatturnos.add(tticket);
            }
        } catch (Exception ex) {
            System.out.println("Error :: " + ex);
        }

        return lstatturnos;
    }
}
