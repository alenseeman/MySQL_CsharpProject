using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace IznajmljivanjeSkiOpreme
{
    public partial class RadnikForma : Form
    {
        public static string jmbgradnik = "1111999163302";
        public static string jmbgkorisnik = "0211993111946";
        public RadnikForma()
        {
            InitializeComponent();
            this.Activated += new EventHandler(Form1_Activated);

        }
        void Form1_Activated(object sender, EventArgs e)
        {
            provjera();
        }

        private void RadnikForma_Load(object sender, EventArgs e)
        {
            radioButton1.Checked = true;
            MySqlConnection konekcija = ConnectionPool.checkOutConnection();
            MySqlCommand cmd = konekcija.CreateCommand();
            cmd.CommandText = "SELECT Ime from OSOBA where jmbg=" + jmbgradnik;
            MySqlDataReader read = cmd.ExecuteReader();
            while (read.Read())
            {
                label2.Text = read["Ime"].ToString();

            }
            read.Close();
            MySqlCommand cmdd = konekcija.CreateCommand();
            cmdd.CommandText = "SELECT Ime from OSOBA where jmbg=" + jmbgkorisnik;
            MySqlDataReader readd = cmdd.ExecuteReader();
            while (readd.Read())
            {
                label5.Text = readd["Ime"].ToString();

            }
            readd.Close();
            provjera();

        }
        public void provjera()
        {
            MySqlConnection konekcija = ConnectionPool.checkOutConnection();
            MySqlCommand c = konekcija.CreateCommand();
            if (radioButton1.Checked) //REZERVACIJE
            {
                c.CommandText = "select * from rezervacijeBuduceSvihKorisnika;";
            }
            else   //IZNAJMLJIVANJA
                c.CommandText = "select * from iznajmljivanjaDanasSvihKorisnika;";

            MySqlDataReader read = c.ExecuteReader();
            var dataTable = new DataTable();
            dataTable.Load(read);
            dataGridView1.DataSource = dataTable;
            dataGridView1.Columns[0].Visible = false;
        }

        private void button6_Click(object sender, EventArgs e)
        {
            SkiObucaForma sof = new SkiObucaForma(false);
            sof.Show();
        }

        private void button5_Click(object sender, EventArgs e)
        {
            SkiOpremaForma skf = new SkiOpremaForma();
            skf.Show();
        }

        private void button7_Click(object sender, EventArgs e)
        {
            if (dataGridView1.SelectedRows.Count > 0)
            {
                if (radioButton1.Checked)
                {
                    string jmbgz = "";
                    MySqlConnection konekcija = ConnectionPool.checkOutConnection();
                    MySqlCommand cmd = konekcija.CreateCommand();
                    cmd.CommandText = "call provjeraCijaJeRezervacija(" + int.Parse(dataGridView1.CurrentRow.Cells[0].Value.ToString()) + ");";
                    MySqlDataReader read = cmd.ExecuteReader();
                    string dat = "";
                    DateTime aa = DateTime.Today;
                    while (read.Read())
                    {
                        dat = read["RezervisanoZaDan"].ToString();
                        jmbgz = read["JMBG"].ToString();

                    }
                    read.Close();
                    if (jmbgz.Equals(jmbgkorisnik) && dat.Substring(0, 9).Equals(aa.Date.ToString("M/d/yyyy")))
                    {
                        long idPK = 0;
                        MySqlCommand cmdd = konekcija.CreateCommand();
                        cmdd.CommandText = "update rezervacija set Otkazano=1 where IdRezervacije=" + int.Parse(dataGridView1.CurrentRow.Cells[0].Value.ToString()) + ";";
                        cmdd.ExecuteNonQuery();
                        MySqlCommand c = konekcija.CreateCommand();
                        c.CommandText = "insert into iznajmljivanje (JMBGZaposleni,JMBG,IznajmljenoOdDatuma,CijenaIznajmljivanja) values('" + jmbgradnik + "','" + jmbgkorisnik + "','" + aa.Date.ToString("yyyy-MM-dd") + "',999);";
                        c.ExecuteNonQuery();
                        idPK = c.LastInsertedId;
                        MySqlCommand cmddd = konekcija.CreateCommand();
                        cmddd.CommandText = "call svaRezervisanaObucaId(" + int.Parse(dataGridView1.CurrentRow.Cells[0].Value.ToString()) + ");";
                        MySqlDataReader readd = cmddd.ExecuteReader();
                        int idOb;
                        double cije;
                        while (readd.Read())
                        {
                            idOb = int.Parse(readd["IdObuce"].ToString());
                            cije = double.Parse(readd["Cijena"].ToString());
                            MySqlConnection konekcijaa = ConnectionPool.checkOutConnection();
                            MySqlCommand cm = konekcijaa.CreateCommand();
                            cm.CommandText = "insert into i_obuca values(" + idPK + "," + idOb + "," + cije + ");";
                            cm.ExecuteNonQuery();
                        }
                        readd.Close();
                        MySqlCommand cmde = konekcija.CreateCommand();
                        cmde.CommandText = "call svaRezervisanaOpremaId(" + int.Parse(dataGridView1.CurrentRow.Cells[0].Value.ToString()) + ");";
                        MySqlDataReader readder = cmde.ExecuteReader();

                        while (readder.Read())
                        {
                            idOb = int.Parse(readder["IdOpreme"].ToString());
                            cije = double.Parse(readder["Cijena"].ToString());
                            MySqlConnection konekcij = ConnectionPool.checkOutConnection();
                            MySqlCommand cm = konekcij.CreateCommand();
                            cm.CommandText = "insert into i_oprema values(" + idPK + "," + idOb + "," + cije + ");";
                            cm.ExecuteNonQuery();
                        }
                        readder.Close();

                        MessageBox.Show("Vasa rezervacija je prosla !");
                        //provjera();
                    }
                    else
                        MessageBox.Show("Nije moguce preuzeti rezervaciju");

                }

                else
                    MessageBox.Show("Niste izabrali nijednu rezervaciju !");
            }
            else
                MessageBox.Show("Niste izabrali nijednu rezervaciju !");

        }

        private void radioButton1_CheckedChanged(object sender, EventArgs e)
        {
            provjera();
            label6.Text = "Lista svih rezervacija:";
        }

        private void radioButton2_CheckedChanged(object sender, EventArgs e)
        {
            provjera();
            label6.Text = "Lista svih iznajmljivanja za danasnji dan:";
        }

        private void button8_Click(object sender, EventArgs e)
        {
            VracenaOpremaForma vof = new VracenaOpremaForma();
            vof.Show();
        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void button9_Click(object sender, EventArgs e)
        {
            NovaRezervacija nf = new NovaRezervacija(jmbgradnik, jmbgkorisnik, true);
            nf.Show();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (dataGridView1.SelectedRows.Count > 0)
            {
                String datumm = dataGridView1.CurrentRow.Cells[2].Value.ToString().Substring(0, 10);
                if (radioButton2.Checked) //REZERVACIJE
                {
                    PrikazOpremaObuca poo = new PrikazOpremaObuca("IZNAJMLJIVANJE", int.Parse(dataGridView1.CurrentRow.Cells[0].Value.ToString()), datumm);
                    poo.Show();
                }
                else
                {
                    PrikazOpremaObuca poo = new PrikazOpremaObuca("zad", int.Parse(dataGridView1.CurrentRow.Cells[0].Value.ToString()), datumm);
                    poo.Show();

                }
            }
            else
                MessageBox.Show("Niste izabrali nijednu stavku iz tabele!");
        }

        private void button2_Click(object sender, EventArgs e)
        {
            DodajObucu dod = new DodajObucu();
            dod.Show();
        }
    }
}
 

