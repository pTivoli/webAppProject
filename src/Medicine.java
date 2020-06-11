public class Medicine {
    private String receipt; //?? IT MUST BE CHANGED ASAP
    private String expirationDate; //?? IT MUST BE CHANGED ASAP
    private String name;
    private Integer code;

    public String getReceipt() {
        return receipt;
    }

    public void setReceipt(String receipt) {
        this.receipt = receipt;
    }

    public String getExpirationDate() { return expirationDate; }

    public void setExpirationDate(String expirationDate) {
        this.expirationDate = expirationDate;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }
}
