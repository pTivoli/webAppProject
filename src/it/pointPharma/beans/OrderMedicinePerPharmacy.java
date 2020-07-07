package it.pointPharma.beans;

import it.pointPharma.generalClasses.*;
import org.apache.struts.action.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.StringTokenizer;

public class OrderMedicinePerPharmacy extends Action{

    private LinkedList<Medicine> listMedicine;

    public OrderMedicinePerPharmacy(){
        listMedicine = new LinkedList<Medicine>();
    }

    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String medicines = (String) request.getParameter("medicine");
        HttpSession session = request.getSession(true);
        PharmacistManager pm = (PharmacistManager) session.getAttribute("pharmacist");
        Pharmacy pharmacy = (Pharmacy) session.getAttribute("pharmacy");
        this.listMedicine = this.listGenerator(medicines);

        try{
            pm.restockMedicine(this.listMedicine, pharmacy);
        } catch (Exception e) {
            PrintWriter out = response.getWriter();
            out.println(e.getMessage());
            out.flush();
        }

        return null;
    }

    private LinkedList<Medicine> listGenerator(String txtAjaxCall){
        LinkedList<Medicine> med = new LinkedList<Medicine>();
        StringTokenizer str = new StringTokenizer(txtAjaxCall, ",");
        boolean first = true;
        while(str.hasMoreTokens()){
            String code = str.nextToken();
            if(first){
                code = code.substring("medicine=".length());
                first = false;
            }
            Medicine tmp = new Medicine();
            tmp.setCode(code);
            med.add(tmp);
        }
        return med;
    }

}
