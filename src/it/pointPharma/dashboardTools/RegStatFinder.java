package it.pointPharma.dashboardTools;

import org.apache.struts.action.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class RegStatFinder extends Action {
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession(true);
        String regFName = (String) request.getParameter("regFName");
        String regLName = (String) request.getParameter("regLName");
        String regCF = (String) request.getParameter("regCF");
        String regEmail = (String) request.getParameter("regEmail");
        String regDoB = (String) request.getParameter("regDoB");
        String stat = (String) request.getParameter("stat");

        if (stat.equals("getTotalSalesPerPharmacy")) {
            String result = this.getTotalSalesPerPharmacy();
            PrintWriter out = response.getWriter();
            out.println(result);
            out.flush();
        }

        return null;
    }

    private String getTotalSalesPerPharmacy() throws Exception{
        try {
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost/PharmaPoint", "PharmaPointDBAccess", "PharmaPointDBAccess");
            String result = "";
            try {
                Statement st = con.createStatement();
                String query = "";



            } catch (SQLException e){
                throw new Exception("Error DB");
            }
            return result;
        } catch (SQLException e){
            throw new Exception("Error DB");
        }

    }
}
