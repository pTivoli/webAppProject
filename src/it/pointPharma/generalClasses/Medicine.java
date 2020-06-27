package it.pointPharma.generalClasses;

import java.util.Date;

public class Medicine {
    private boolean receipt;
    private Date ED;
    private String name;
    private String code;
    private float cost;

    public boolean needsReceipt() {
        return receipt;
    }

    public void setReceipt(boolean receipt) { this.receipt = receipt; }

    public Date getED() { return ED; }

    public void setED(Date expirationDate) {
        this.ED = expirationDate;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public float getCost() { return cost; }

    public void setCost(float cost) { this.cost = cost; }

}
