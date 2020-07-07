package it.pointPharma.beans;

import it.pointPharma.generalClasses.*;
import org.apache.struts.action.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.StringTokenizer;

public class SellItemsGeneral extends Action{

    private LinkedList<Medicine> listMedicine;

    public SellItemsGeneral(){
        listMedicine = new LinkedList<Medicine>();
    }

    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String medicines = (String)request.getParameter("medicine");
        HttpSession session = request.getSession(true);
        this.listMedicine = this.listGenerator(medicines);
        String codRec = (String)request.getParameter("codRec");
        if(codRec == null || codRec.equals("")){
            DeskOperator deskOperator = (DeskOperator)session.getAttribute("pharmacist");
            deskOperator.sellItems(listMedicine, (Pharmacy)session.getAttribute("pharmacy"), null, "");
        }else {
            String dateRec = (String) request.getParameter("dateRec");
            String codDocRec = (String) request.getParameter("codDocRec");
            String cfRec = (String) request.getParameter("cfRec");
            Pharmacist pharmacist = (Pharmacist) session.getAttribute("pharmacist");
            User user = new User();
            user.setCF(cfRec);
            if (pharmacist instanceof PharmacistManager) {
                PharmacistManager pharmacistManager = (PharmacistManager) pharmacist;
                try {
                    pharmacistManager.sellItemsWithReceipt(this.listMedicine, user, codDocRec, (Pharmacy) session.getAttribute("pharmacy"), codRec, dateRec);
                } catch (Exception e) {
                    PrintWriter out = response.getWriter();
                    out.println(e.getMessage());
                    out.flush();
                }
            } else {
                PharmacyDoctor pharmacyDoctor = (PharmacyDoctor) pharmacist;
                try {
                    pharmacyDoctor.sellItemsWithReceipt(this.listMedicine, user, codDocRec, (Pharmacy) session.getAttribute("pharmacy"), codRec, dateRec);
                } catch (Exception e) {
                    PrintWriter out = response.getWriter();
                    out.println(e.getMessage());
                    out.flush();
                }
            }
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
            tmp.setName(str.nextToken());
            med.add(tmp);
        }
        return med;
    }

}
