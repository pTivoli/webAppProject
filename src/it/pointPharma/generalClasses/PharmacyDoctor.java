package it.pointPharma.generalClasses;

import java.sql.*;
import java.util.Date;
import java.util.LinkedList;

public class PharmacyDoctor extends DeskOperator{

    public boolean sellItemsWithReceipt(LinkedList<Medicine> medicineLinkedList, User user, Date date, Integer codRegDoc, Pharmacy pharmacy, String recipeCode) throws Exception {
        try{
            Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/PharmaPoint", "postgresql", "Franci99");
            try {
                Statement st = con.createStatement();
                String checkUser = "select count (codicefiscale)\n" +
                        "from persona\n" +
                        "where codicefiscale = '" + user.getCF() + "'";
                ResultSet ris = st.executeQuery(checkUser);
                int checkDB = 0;
                while(ris.next()){
                    checkDB = Integer.parseInt(ris.getString("count"));
                }

                if(checkDB == 0){
                    if(!registerUser(user)){
                        return false;
                    }
                }

                LinkedList<Medicine> examined = new LinkedList<Medicine>();
                float totalCost = 0;
                String mqty;
                String queryMedPurchase;

                for (Medicine m  : medicineLinkedList ){

                    /* has a medicine of the same type already been examined? */
                    if(!examined.contains(m)){
                        examined.add(m);
                        int quantity = countDuplicates(medicineLinkedList, m);
                        queryMedPurchase = ("INSERT INTO Acquisto_Farmaco VALUES('" + quantity + "', '" + date + "', '" + this.getCF() + "', '" + m.getCode() + "'");
                        st.executeUpdate(queryMedPurchase);
                    }

                    if(m.needsReceipt()){
                        String queryRecipe = ("INSERT INTO ricetta VALUES('" + recipeCode + "', '" + date + "', '" + user.getCF() + "', '" + codRegDoc + "', '" + this.getCF() + "'");
                        st.executeUpdate(queryRecipe);
                    }

                    totalCost += m.getCost();
                    mqty = ("update magazzino_farmaco as mf " +
                            "set quantita = mf.quantita - 1 " +
                            "where mf.codiceFarmaco = (select distinct farmaco.codice " +
                            "from magazzino_farmaco " +
                            "join farmacia on magazzino_farmaco.nomeFarmaciaMagazzino = farmacia.nome " +
                            "join farmaco on magazzino_farmaco.codiceFarmaco = farmaco.codice " +
                            "where magazzino_farmaco.codiceFarmaco = '" + m.getCode() + "' and farmacia.nome = '" + pharmacy.getName() + "'");
                    st.executeUpdate(mqty);
                }
                String queryPurchase = ("INSERT INTO Acquisto VALUES('" + date + "', '" + this.getCF() + "', '" + this.getEmail() + "', null '" + totalCost + "'");
                st.executeUpdate(queryPurchase);
                return true;
            } catch (SQLException e) {
                return false;
            }
        } catch (SQLException e) {
            return false;
        }

    }

    public boolean registerUser(User user) throws Exception {
        try{
            Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/PharmaPoint", "postgresql", "TivoliPatrick");
            try{
                Statement st = con.createStatement();
                String queryUtente = "INSERT INTO Persona VALUES ('"+ user.getCF() +"',' "+ user.getfName() +"',' "+ user.getlName() +"','"+user.getDOB()+"')";
                st.executeUpdate(queryUtente);
            }catch(SQLException ex){
                return false;
                //throw new Exception("Error DB");
            }
            con.close();
            return true;
        }catch(Exception e){
            return false;
            //throw new Exception("Error DB");
        }
    }
}
