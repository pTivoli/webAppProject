import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class PharmacistManager extends PharmacyDoctor{

    private void employee(Pharmacist pharmacist) throws Exception {
        try{
            Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/PharmaPoint", "postgresql", "TivoliPatrick");
            try{
                Statement st = con.createStatement();
                String queryUtente = "INSERT INTO Persona VALUES ("+ pharmacist.getCF() +", "+ pharmacist.getfName() +", "+ pharmacist.getlName() +", "+pharmacist.getDOB()+")";
                String queryPersonale;
                if(pharmacist instanceof DeskOperator)
                    queryPersonale = "INSERT INTO Personale VALUES ("+pharmacist.getEmail()+", "+pharmacist.getPwd()+", "+pharmacist.getCF()+", DO)";
                else
                    queryPersonale = "INSERT INTO Personale VALUES ("+pharmacist.getEmail()+", "+pharmacist.getPwd()+", "+pharmacist.getCF()+", DF)";
                st.executeUpdate(queryUtente);
                st.executeUpdate(queryPersonale);
            }catch(SQLException ex){
                throw new Exception("Error DB");
            }
            con.close();
        }catch(Exception e){
            throw new Exception("Error DB");
        }
    }

    public void employeePD(PharmacyDoctor pharmacyDoctor) throws Exception {
        try {
            this.employee(pharmacyDoctor);
        }catch(Exception e){
            throw e;
        }
    }

    public void employeeDO(DeskOperator deskOperator) throws Exception {
        try {
            this.employee(deskOperator);
        }catch(Exception e){
            throw e;
        }
    }

    /* STATISTICS */

}
