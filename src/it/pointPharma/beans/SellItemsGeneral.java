package it.pointPharma.beans;

import it.pointPharma.generalClasses.DeskOperator;
import it.pointPharma.generalClasses.Medicine;
import it.pointPharma.generalClasses.Pharmacy;
import org.apache.struts.action.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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
        DeskOperator deskOperator = (DeskOperator)session.getAttribute("pharmacist");
        deskOperator.sellItems(listMedicine, (Pharmacy)session.getAttribute("pharmacy"));
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
