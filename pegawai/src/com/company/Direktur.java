package com.company;

public class Direktur extends Pegawai{
    private int tKesehatan = 2000000, tBensin = 50000;
     private String jabatan = "Direktur";

    public Direktur(String nama, String id, int hariKerja) {
        super(nama, id, hariKerja);
    }

    public int gettKesehatan() {
        return tKesehatan;
    }

    public void settKesehatan(int tKesehatan) {
        this.tKesehatan = tKesehatan;
    }

    public int gettBensin() {
        return tBensin;
    }

    @Override
    public String getJabatan() {
        return jabatan;
    }

    @Override
    public void setJabatan(String jabatan) {
        this.jabatan = jabatan;
    }

    public void settBensin(int tBensin) {
        this.tBensin = tBensin;
    }

    @Override
    public void hitungGaji() {
        double jmlGaji = (getGajiPokok()*4) + (gettTransport()*getHariKerja()) + gettKesehatan() + gettBensin();
        super.setJmlGaji(jmlGaji);
    }

    @Override
    public void tampilkan() {
        super.tampilkan();
    }
}
