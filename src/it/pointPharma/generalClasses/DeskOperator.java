package it.pointPharma.generalClasses;

import java.sql.*;
import java.util.LinkedList;

public class DeskOperator extends Pharmacist {

    public void sellItems(LinkedList<Medicine> medicineLinkedList, Pharmacy pharmacy, Timestamp timestamp, String cf) throws Exception {
        try{
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/PharmaPoint", "PharmaPointDBAccess", "PharmaPointDBAccess");
            try {
                Statement st = con.createStatement();
                String queryPurchase;
                String queryMedPurchase;
                String mqty;
                LinkedList<Medicine> examined = new LinkedList<Medicine>();
                float totalCost = 0;
                if(timestamp == null){
                    timestamp = new Timestamp(System.currentTimeMillis());
                }
                String timest = timestamp.toString();
                if("".equals(cf))
                    queryPurchase = ("INSERT INTO Acquisto VALUES('" + timest + "' , '" + this.getCF() + "', '" + this.getEmail() + "', null ," + totalCost + ")");
                else
                    queryPurchase = ("INSERT INTO Acquisto VALUES('" + timest + "' , '" + this.getCF() + "', '" + this.getEmail() + "', '"+cf+"' ," + totalCost + ")");
                st.executeUpdate(queryPurchase);
                int quantity = 0;
                for (Medicine m  : medicineLinkedList ){
                    if(!(isIn(examined, m.getCode()))) {
                        examined.add(m);
                        quantity = countDuplicates(medicineLinkedList, m);
                        queryMedPurchase = "INSERT INTO Acquisto_Farmaco VALUES('" + quantity + "', '" + timest + "' , '" + this.getCF() + "', '" + m.getCode() + "')";
                        st.executeUpdate(queryMedPurchase);
                        String queryFindCost = "select prezzo from farmaco where codice='" + m.getCode() + "';";
                        ResultSet r = st.executeQuery(queryFindCost);
                        r.next();
                        m.setCost(r.getFloat("prezzo"));
                    }
                    for(int i = 0; i < quantity; i++)
                        totalCost += m.getCost();
                    mqty = "update magazzino_farmaco as mf \n" +
                            "set quantita = mf.quantita - 1 \n" +
                            "where mf.codiceFarmaco = '" + m.getCode() + "'\n" +
                            "and mf.nomefarmaciamagazzino = '" + pharmacy.getName() + "';";
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
            if(check.getCode().equals(m.getCode())) { count++; }
        }
        return count;
    }

    public boolean isIn(LinkedList<Medicine> med, String m){
        for(Medicine mp : med) {
            if (mp.getCode().equals(m)) {
                return true;
            }
        }
        return false;
    }

    /*public boolean contains(Object o){
        if(o instanceof  Medicine){
            Medicine m = (Medicine)o;
            if(m.getCode() == ((Medicine) o).getCode())
                return true;
            else
                return false;
        }else
            return false;
    }*/
}