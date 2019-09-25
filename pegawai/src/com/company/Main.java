package com.company;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;

public class Main {
    BufferedReader pacman = new BufferedReader(new InputStreamReader(System.in));
    ArrayList<Pegawai> pegawais = new ArrayList<>();
    public static void main(String[] args) {
	// write your code here

    Main main = new Main();
    main.runTthis();

    }

    int cariPosisi(String id, String nama){
        int pos = -1;
        for(int i = 0; i < pegawais.size(); i++) {
            if (id.equalsIgnoreCase(pegawais.get(i).getId()) || nama.equalsIgnoreCase(pegawais.get(i).getNama())){
                pos = i;
                break;
            }
        }
        return pos;
    }

    void mainMenu() throws Exception{
        int menu;
        do {
            System.out.println("..:::Pegawai pabrik maju mundur:::..");
            System.out.println("1. tambah pegawai \n" +
                    "2. pecat pegawai \n" +
                    "3. cari pegawai \n" +
                    "4. tampilkan semua pegawai \n" +
                    "5. keluar");
            System.out.print("Pilihan   : ");
            menu = Integer.parseInt(pacman.readLine());
            switch (menu) {
                case 1:
                    tambahPegawai();
                    break;
                case 2:
                    pecatPegawai();
                    break;
                case 3:
                    cariPegawai();
                    break;
                case 4:
                    showAll();
                    break;

            }
        }while(menu != 5);
    }

    void tambahPegawai() {
        int jbtn, hariKerja, id;
        String nama, jId;

        id = pegawais.size() + 1;
        jId = Integer.toString(id);
        try {
            System.out.println("..:::Tambah Pegawai:::...");
            System.out.print("Nama Pegawai          : ");
            nama = pacman.readLine();
            System.out.print("Jumlah hari kerja   : ");
            hariKerja = Integer.parseInt(pacman.readLine());
            System.out.println("Jabatan Pegawai     : ");
            System.out.println("1. Staff \n" +
                    "2. Manajer \n" +
                    "3. Direktur");
            jbtn = Integer.parseInt(pacman.readLine());
            switch (jbtn){
                case 1:
                    Pegawai staff = new Pegawai(nama, jId, hariKerja);
                    staff.hitungGaji();
                    pegawais.add(staff);
                    break;
                case 2:
                    Pegawai manajer = new Manajer(nama, jId, hariKerja);
                    manajer.hitungGaji();
                    pegawais.add(manajer);
                    break;
                case 3:
                    Pegawai direktur = new Direktur(nama, jId, hariKerja);
                    direktur.hitungGaji();
                    pegawais.add(direktur);
                    break;
            }

        }catch(Exception e){
            System.out.println(e.getMessage());
        }
    }

    void cariPegawai(){
        try{
            System.out.println("..:::CAri pegawai:::...");
            System.out.print("Masukan Nama/ID Pegawai : ");
            String nid = pacman.readLine();

            int pos = cariPosisi(nid, nid);

            if(pos == -1){
                System.out.println("Pegawai tidak ada");
            }else{
                System.out.println("info pegawai");
                System.out.println("id pegawai              : "+pegawais.get(pos).getId());
                System.out.println("nama pegawai            : "+pegawais.get(pos).getNama());
                System.out.println("jabatan pegawai         : "+pegawais.get(pos).getJabatan());
                System.out.println("hari kerja              : "+pegawais.get(pos).getHariKerja());
                System.out.println("jumlah gaji             : "+pegawais.get(pos).getJmlGaji());
            }
        }catch (Exception e){
            System.out.println(e.getMessage());
        }
    }

    void pecatPegawai(){
        try {
            System.out.println("pecat pegawau");
            System.out.print("Masukan nama/id : ");
            String nid = pacman.readLine();

            int pos = cariPosisi(nid, nid);

            if(pos == -1){
                System.out.println("Pegawai tidak ada");
            }else{
                pegawais.remove(pos);
            }


        }catch (Exception e){
            System.out.println(e.getMessage());
        }
    }

    void showAll(){
        for (int i = 0; i < pegawais.size(); i++){
                System.out.println("info pegawai");
                System.out.println("id pegawai              : "+pegawais.get(i).getId());
                System.out.println("nama pegawai            : "+pegawais.get(i).getNama());
                System.out.println("jabatan pegawai         : "+pegawais.get(i).getJabatan());
                System.out.println("hari kerja              : "+pegawais.get(i).getHariKerja());
                System.out.println("jumlah gaji             : "+pegawais.get(i).getJmlGaji());

        }
    }

    void runTthis(){
        try{
            mainMenu();
        }catch (Exception e){
            System.out.println(e.getMessage());
        }
    }

}
