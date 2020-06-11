public class Pharmacy {

    private String name;
    private String address;
    private String phoneNumber;
    private PharmacyDoctor pharmacyDoctor;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() { return address; }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String pN) {
        this.phoneNumber = pN;
    }

    public PharmacyDoctor getPharmacyDoctor() {
        return pharmacyDoctor;
    }

    public void setPharmacyDoctor(PharmacyDoctor pharmacyDoctor) {
        this.pharmacyDoctor = pharmacyDoctor;
    }

}
