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
                Timestamp timestamp = new Timestamp(System.currentTimeMillis());
                String timest = timestamp.toString();
                queryPurchase = ("INSERT INTO Acquisto VALUES('" + timest + "' , '" + this.getCF() + "', '" + this.getEmail() + "', null ," + totalCost + ")");
                System.out.println(queryPurchase);
                st.executeUpdate(queryPurchase);
                for (Medicine m  : medicineLinkedList ){
                    if(!examined.contains(m)){
                        examined.add(m);
                        int quantity = countDuplicates(medicineLinkedList, m);
                        queryMedPurchase = "INSERT INTO Acquisto_Farmaco VALUES('"+quantity+"', '"+timest+"' , '"+this.getCF()+"', '"+m.getCode()+"')";
                        System.out.println(queryMedPurchase);
                        st.executeUpdate(queryMedPurchase);
                    }
                    totalCost += m.getCost();
                    mqty = "update magazzino_farmaco as mf \n" +
                            "set quantita = mf.quantita - 1 \n" +
                            "where mf.codiceFarmaco = '" + m.getCode() + "'\n" +
                            "and mf.nomefarmaciamagazzino = '" + pharmacy.getName() + "';";
                    System.out.println(mqty);
                    st.executeUpdate(mqty);

                    String updateTot = "update Acquisto\n" +
                            "set totale = "+totalCost+"\n" +
                            "where timest = '"+timest+"'\n" +
                            "and cfPersonale = '"+this.getCF()+"'";
                    st.executeUpdate(updateTot);

                }
            } catch (SQLException e) {
                throw new SQLException("Error DB");
            }
        } catch (SQLException e) {
            throw new SQLException("Error DB");
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