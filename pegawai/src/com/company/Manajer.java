package com.company;

public class Manajer extends Pegawai {
    private int tKesehatan = 1000000;
    private String jabatan = "Manajer";

    public int gettKesehatan() {
        return tKesehatan;
    }

    public void settKesehatan(int tKesehatan) {
        this.tKesehatan = tKesehatan;
    }

    public Manajer(String nama, String id, int hariKerja) {
        super(nama, id, hariKerja);
    }

    @Override
    public String getJabatan() {
        return jabatan;
    }

    @Override
    public void setJabatan(String jabatan) {
        this.jabatan = jabatan;
    }

    @Override
    public void hitungGaji(){
        double jmlGaji = (getGajiPokok()*2) + (gettTransport()*getHariKerja()) + gettKesehatan();
        super.setJmlGaji(jmlGaji);
    }

    @Override
    public void tampilkan(){
        super.tampilkan();
    }
}
