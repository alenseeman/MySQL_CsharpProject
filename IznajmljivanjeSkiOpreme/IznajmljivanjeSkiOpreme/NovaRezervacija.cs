using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Collections;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace IznajmljivanjeSkiOpreme
{
    public partial class NovaRezervacija : Form
    {
        public static string jmbgradnik;
        public static string jmbgkorisnik;
        public static bool izna;
        public static HashSet<int> rezOprema = new HashSet<int>();
        public static HashSet<int> rezObuca = new HashSet<int>();
        public NovaRezervacija(string rad, string kor,bool a)
        {
            InitializeComponent();
            izna = a;
            jmbgkorisnik = kor;
            jmbgradnik = rad;

        }

        private void NovaRezervacija_Load(object sender, EventArgs e)
        {
            if(izna)
            {
                label10.Visible = false;
                datumPocetkaDateTimePicker.Visible = false;
                label5.Text = "Novo iznajmljivanje:";
                label3.Text = "Broj stavki za iznajmljivanje:";
                button1.Text = "Iznajmi!";
            }
            radioButton1.Checked = true;
            MySqlConnection konekcija = ConnectionPool.checkOutConnection();
            MySqlCommand cmd = konekcija.CreateCommand();
            cmd.CommandText = "SELECT Ime from OSOBA where jmbg=" + jmbgradnik;
            MySqlDataReader read = cmd.ExecuteReader();
            while (read.Read())
            {
                label6.Text = read["Ime"].ToString();
            }
            read.Close();
            MySqlCommand cmdd = konekcija.CreateCommand();
            cmdd.CommandText = "SELECT Ime from OSOBA where jmbg=" + jmbgkorisnik;
            MySqlDataReader reader = cmdd.ExecuteReader();
            while (reader.Read())
            {
                label8.Text = reader["Ime"].ToString();
            }
            konekcija.Close();
            provjera();
            
        }

        public void provjera()
        {
            String dat = "";
            DateTime aa = DateTime.Today;
            if (izna)
            {
                dat = aa.Date.ToString("yyyy.MM.dd");
            }
            else
            {
                dat = datumPocetkaDateTimePicker.Value.Date.ToString("yyyy.MM.dd");
            }  
            MySqlConnection konekcija = ConnectionPool.checkOutConnection();
            MySqlCommand cmd = konekcija.CreateCommand();
            if (radioButton1.Checked)
            {
                cmd.CommandText = "call dostupniSnowboardiRezervacija('" + dat+"');";
                    
            }
            else if (radioButton2.Checked)
            {
                cmd.CommandText = "call dostupneSkijeRezervacija('" + dat+"');";
            }
            else
            {
                cmd.CommandText = "call dostupnaObucaRezervacija('" + dat+"');";
            }
            MySqlDataReader read = cmd.ExecuteReader();
            var dataTable = new DataTable();
            dataTable.Load(read);
            dataGridView1.DataSource = dataTable;
            dataGridView1.Columns[0].Visible = false;
        }

        private void datumPocetkaDateTimePicker_ValueChanged(object sender, EventArgs e)
        {
            rezOprema.Clear();
            rezObuca.Clear();
            label4.Text = rezObuca.Count +rezOprema.Count+ "";
            if (DateTime.Compare(datumPocetkaDateTimePicker.Value, DateTime.Today) < 0)
                datumPocetkaDateTimePicker.Value = DateTime.Today;
            provjera();
        }

        private void radioButton1_CheckedChanged(object sender, EventArgs e)
        {
            provjera();
        }

        private void radioButton2_CheckedChanged(object sender, EventArgs e)
        {
            provjera();
        }

        private void radioButton3_CheckedChanged(object sender, EventArgs e)
        {

            provjera();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (dataGridView1.SelectedRows.Count > 0)
            {
                if (radioButton3.Checked)
                {
                    rezObuca.Add(int.Parse(dataGridView1.CurrentRow.Cells[0].Value.ToString()));
                }
                else
                    rezOprema.Add(int.Parse(dataGridView1.CurrentRow.Cells[0].Value.ToString()));
                label4.Text = rezObuca.Count + rezOprema.Count + "";
                

            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            int ukupanBroj = rezObuca.Count + rezOprema.Count;
            if (ukupanBroj != 0)
            {
                DateTime aa = DateTime.Now;
                String dat = datumPocetkaDateTimePicker.Value.Date.ToString("yyyy-MM-dd");
                long idPK = 0;

                if (!(izna) && dat.Equals(aa.Date.ToString("yyyy-MM-dd")) && int.Parse(aa.Hour.ToString()) > 11)
                {
                    MessageBox.Show("U ovom terminu nije moguće rezervisati stavku!");
                }
                else
                {
                    MySqlConnection konekcija = ConnectionPool.checkOutConnection();
                    MySqlCommand cmd = konekcija.CreateCommand();

                    if (izna)
                    {
                        cmd.CommandText = "insert into iznajmljivanje (JMBGZaposleni,JMBG,IznajmljenoOdDatuma,CijenaIznajmljivanja) values('" + jmbgradnik + "','" + jmbgkorisnik + "','" + aa.Date.ToString("yyyy.MM.dd") + "',0);";
                    }
                    else
                        cmd.CommandText = "insert into rezervacija (JMBGZaposleni,JMBG,RezervisanoZaDan,DatumRezervacije,Otkazano) values('" + jmbgradnik + "','" + jmbgkorisnik + "','" + dat + "','" + aa.Date.ToString("yyyy.MM.dd") + "',0);";
                    cmd.ExecuteNonQuery();
                    idPK = cmd.LastInsertedId;
                    for (int i = 0; i < rezObuca.Count; i++)
                    {
                        MySqlCommand cmdd = konekcija.CreateCommand();
                        if (izna)
                        {
                            cmdd.CommandText = "insert into i_obuca (IdIznajmljivanja,IdObuce) values(" + idPK + "," + rezObuca.ElementAt(i) + ");";
                        }
                        else
                            cmdd.CommandText = "insert into r_obuca (IdRezervacije,IdObuce) values(" + idPK + "," + rezObuca.ElementAt(i) + ");";
                        cmdd.ExecuteNonQuery();

                    }
                    for (int j = 0; j < rezOprema.Count; j++)
                    {
                        MySqlCommand cmdd = konekcija.CreateCommand();
                        if (izna)
                        {
                            cmdd.CommandText = "insert into i_oprema (IdIznajmljivanja,IdOpreme) values(" + idPK + "," + rezOprema.ElementAt(j) + ");";

                        }
                        else
                            cmdd.CommandText = "insert into r_oprema (IdRezervacije,IdOpreme) values(" + idPK + "," + rezOprema.ElementAt(j) + ");";
                        cmdd.ExecuteNonQuery();
                    }
                    MessageBox.Show("Uspješno !");
                    rezOprema.Clear();
                    rezObuca.Clear();
                    label4.Text = rezObuca.Count + rezOprema.Count + "";
                    provjera();

                }
            }
            else
            {
                MessageBox.Show("Niste izabrali nijednu stavku!");
            }
        }

        private void label4_Click(object sender, EventArgs e)
        {

        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
