using IznajmljivanjeSkiOpreme;
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
    public partial class Form1 : Form
    {
        public static string jmbgradnik= "1111999163302";
        public static string jmbgkorisnik="0211993111946";
        public Form1()
        {
            InitializeComponent();
            this.Activated += new EventHandler(Form1_Activated);

        }
        void Form1_Activated(object sender, EventArgs e)
        {
            provjera();
        }


        private void button7_Click(object sender, EventArgs e)
        {
            if (dataGridView1.SelectedRows.Count > 0)
            {
                String datumm = dataGridView1.CurrentRow.Cells[3].Value.ToString().Substring(0, 10);

                PrikazOpremaObuca pkz = new PrikazOpremaObuca("rez",int.Parse(dataGridView1.CurrentRow.Cells[0].Value.ToString()), datumm);
                pkz.Show();
            }

            else
                MessageBox.Show("Niste izabrali nijednu rezervaciju !");
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void panel2_Paint(object sender, PaintEventArgs e)
        {

        }

        private void Form1_Load_1(object sender, EventArgs e)
        {
            MySqlConnection konekcija = ConnectionPool.checkOutConnection();
            MySqlCommand cmd = konekcija.CreateCommand();
            cmd.CommandText = "SELECT Ime from OSOBA where jmbg="+jmbgradnik;
            MySqlDataReader read = cmd.ExecuteReader();
            while (read.Read())
            {
                label2.Text = read["Ime"].ToString();

            }
            read.Close();
            MySqlCommand cmdd = konekcija.CreateCommand();
            cmdd.CommandText = "SELECT Ime from OSOBA where jmbg="+jmbgkorisnik;
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
            MySqlCommand cmddd = konekcija.CreateCommand();
            cmddd.CommandText = "call listaSvihRezervacijaKorisnikBuducnost('" + jmbgkorisnik + "');";
            MySqlDataReader readdd = cmddd.ExecuteReader();
            var dataTable = new DataTable();
            dataTable.Load(readdd);
            dataGridView1.DataSource = dataTable;
            dataGridView1.Columns[0].Visible = false;
            konekcija.Close();
        }
   


        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void button5_Click(object sender, EventArgs e)
        {
            SkiOpremaForma skf = new SkiOpremaForma();
            skf.Show();
        }

        private void button6_Click(object sender, EventArgs e)
        {
            SkiObucaForma sof = new SkiObucaForma(true);
            sof.Show();
        }

        private void button9_Click(object sender, EventArgs e)
        {
            NovaRezervacija nf = new NovaRezervacija(jmbgradnik,jmbgkorisnik,false);
            nf.Show();
            
        }

        private void button8_Click(object sender, EventArgs e)
        {
            
            if (dataGridView1.SelectedRows.Count > 0)
            {
                MySqlConnection konekcija = ConnectionPool.checkOutConnection();
                MySqlCommand cmd = konekcija.CreateCommand();
                DateTime aa = DateTime.Today;
                cmd.CommandText = "update rezervacija set Otkazano=1 where IdRezervacije="+ int.Parse(dataGridView1.CurrentRow.Cells[0].Value.ToString())+";";
                cmd.ExecuteNonQuery();
                MessageBox.Show("Uspjesno ste otkazali rezervaciju!");
            }

            else
                MessageBox.Show("Niste izabrali nijednu rezervaciju !");
        }
    }
}
