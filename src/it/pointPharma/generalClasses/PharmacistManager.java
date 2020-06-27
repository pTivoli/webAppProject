package it.pointPharma.generalClasses;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class PharmacistManager extends PharmacyDoctor{

    private void employee(Pharmacist pharmacist, Pharmacy pharmacy) throws Exception {
        try{
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost/PharmaPoint", "PharmaPointDBAccess", "PharmaPointDBAccess");
            try{
                Statement st = con.createStatement();
                String queryUtente = "INSERT INTO Persona VALUES ('"+ pharmacist.getCF() +"','"+ pharmacist.getfName() +"','"+ pharmacist.getlName() +"','"+pharmacist.getDOB()+"');";
                String queryPersonale;
                if(pharmacist instanceof DeskOperator)
                    queryPersonale = "INSERT INTO Personale VALUES ('"+pharmacist.getEmail()+"','"+pharmacist.getPwd()+"','"+pharmacist.getCF()+"','DO', '"+pharmacy.getName()+"', '"+pharmacy.getAddress()+"', '"+pharmacy.getPharmacyManager().getCF()+"');";
                else
                    queryPersonale = "INSERT INTO Personale VALUES ('"+pharmacist.getEmail()+"','"+pharmacist.getPwd()+"','"+pharmacist.getCF()+"','PD', '"+pharmacy.getName()+"', '"+pharmacy.getAddress()+"', '"+pharmacy.getPharmacyManager().getCF()+"');";
                st.executeUpdate(queryUtente);
                st.executeUpdate(queryPersonale);
            }catch(SQLException ex){
                throw new Exception("Error DB");
            }
            con.close();
        }catch(SQLException e){
            throw new Exception("Error DB");
        }
    }

    public void employeePD(PharmacyDoctor pharmacyDoctor, Pharmacy pharmacy) throws Exception {
        try {
            this.employee(pharmacyDoctor, pharmacy);
        }catch(Exception e){
            throw e;
        }
    }

    public void employeeDO(DeskOperator deskOperator, Pharmacy pharmacy) throws Exception {
        try {
            this.employee(deskOperator, pharmacy);
        }catch(Exception e){
            throw e;
        }
    }


    /* STATISTICS */

}
