package com.company;

public class Pegawai {
    private String nama, jabatan = "Staff", id;
    private int gajiPokok = 1000000, hariKerja, tTransport = 50000;
    double jmlGaji;

    public Pegawai(String nama, String id, int hariKerja) {
        this.nama = nama;
        this.id = id;
        this.hariKerja = hariKerja;
    }

    public String getNama() {
        return nama;
    }

    public void setNama(String nama) {
        this.nama = nama;
    }

    public String getJabatan() {
        return jabatan;
    }

    public void setJabatan(String jabatan) {
        this.jabatan = jabatan;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getGajiPokok() {
        return gajiPokok;
    }

    public void setGajiPokok(int gajiPokok) {
        this.gajiPokok = gajiPokok;
    }

    public int getHariKerja() {
        return hariKerja;
    }

    public void setHariKerja(int hariKerja) {
        this.hariKerja = hariKerja;
    }

    public int gettTransport() {
        return tTransport;
    }

    public void settTransport(int tTransport) {
        this.tTransport = tTransport;
    }

    public double getJmlGaji() {
        return jmlGaji;
    }

    public void setJmlGaji(double jmlGaji) {
        this.jmlGaji = jmlGaji;
    }

    public void hitungGaji(){
        jmlGaji = getGajiPokok() + (gettTransport()*getHariKerja());
        setJmlGaji(jmlGaji);
    }

    public void tampilkan(){
        System.out.println("ID         : "+getId());
        System.out.println("Nama       : "+getNama());
        System.out.println("Jabatan    : "+getJabatan());
        System.out.println("Hari Kerja : "+getHariKerja());
        System.out.println("Gaji       : "+getJmlGaji());
    }
}
