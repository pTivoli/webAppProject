package it.pointPharma.generalClasses;

import java.sql.*;
import java.util.LinkedList;

public class DeskOperator extends Pharmacist {

    public void sellItems(LinkedList<Medicine> medicineLinkedList, Pharmacy pharmacy) throws Exception {
        try{
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/PharmaPoint", "PharmaPointDBAccess", "PharmaPointDBAccess");
            try {
                Statement st = con.createStatement();
                String queryPurchase;
                String queryMedPurchase;
                String mqty;
                LinkedList<Medicine> examined = new LinkedList<Medicine>();
                float totalCost = 0;
                for (Medicine m  : medicineLinkedList ){
                    if(!examined.contains(m)){
                        examined.add(m);
                        int quantity = countDuplicates(medicineLinkedList, m);
                        queryMedPurchase = ("INSERT INTO Acquisto_Farmaco VALUES('" + quantity + "', CURRENT_TIMESTAMP , '" + this.getCF() + "', '" + m.getCode() + "'");
                        st.executeUpdate(queryMedPurchase);
                    }
                    totalCost += m.getCost();
                    mqty = "update magazzino_farmaco as mf \n" +
                            "set quantita = mf.quantita - 1 \n" +
                            "where mf.codiceFarmaco = '" + m.getCode() + "'\n" +
                            "and mf.nomefarmaciamagazzino = '" + pharmacy.getName() + "';";
                    st.executeUpdate(mqty);
                }
                queryPurchase = ("INSERT INTO Acquisto VALUES(CURRENT_TIMESTAMP , '" + this.getCF() + "', '" + this.getEmail() + "', null '" + totalCost + "'");
                st.executeUpdate(queryPurchase);
            } catch (SQLException e) {
                throw new Exception("Error DB");
            }
        } catch (SQLException e) {
            throw new Exception("Error DB");
        }
    }

    public int countDuplicates(LinkedList<Medicine> medicineLinkedList, Medicine m) {
        int count = 0;
        for(Medicine check: medicineLinkedList){
            if(check.getCode() == m.getCode()) { count++; }
        }
        return count;
    }

}