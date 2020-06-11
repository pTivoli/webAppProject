public class Pharmacy {

    private String nome;
    private String indirizzo;
    private String telefono;
    private PharmacyDoctor pharmacyDoctor;

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getIndirizzo() {
        return indirizzo;
    }

    public void setIndirizzo(String indirizzo) {
        this.indirizzo = indirizzo;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public PharmacyDoctor getPharmacyDoctor() {
        return pharmacyDoctor;
    }

    public void setPharmacyDoctor(PharmacyDoctor pharmacyDoctor) {
        this.pharmacyDoctor = pharmacyDoctor;
    }

}
