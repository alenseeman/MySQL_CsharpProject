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
    public partial class SkiObucaForma : Form
    {
        public bool korisni;
        public SkiObucaForma(bool korisnik)
        {
            korisni = korisnik;
            InitializeComponent();
            radioButton1.Checked = true;
            radioButton5.Checked = true;
            this.Activated += new EventHandler(Form1_Activated);

        }
        void Form1_Activated(object sender, EventArgs e)
        {
            provjera();
        }

        public void provjera()
        {

            MySqlConnection konekcija = ConnectionPool.checkOutConnection();
            MySqlCommand cmd = konekcija.CreateCommand();
            if (radioButton5.Checked)
            {
                if (radioButton1.Checked)
                {
                    cmd.CommandText = "call dostupnePancericeRezervacija(current_date())";
                }
                else
                    cmd.CommandText = "call pancericeIznajmljene(current_date())";
            }
            else
            {
                if (radioButton1.Checked)
                {
                    cmd.CommandText = "call dostupneBuceRezervacija(current_date())";
                }
                else
                    cmd.CommandText = "call buceIznajmljene(current_date())";
            }

            MySqlDataAdapter myAdapter = new MySqlDataAdapter(cmd); // Adapter
            DataSet ds = new DataSet();
            myAdapter.Fill(ds); // DataSet <- Adapter
            dataGridView1.DataSource = ds.Tables[0];
            dataGridView1.Columns[0].Visible = false;
        }


        private void SkiObucaForma_Load_1(object sender, EventArgs e)
        {
            if (korisni)
                button1.Visible = false;
            provjera();
        }

        private void radioButton5_CheckedChanged(object sender, EventArgs e)
        {
            provjera();
        }

        private void radioButton4_CheckedChanged(object sender, EventArgs e)
        {
            provjera();
        }

        private void radioButton1_CheckedChanged(object sender, EventArgs e)
        {
            provjera();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (dataGridView1.SelectedRows.Count > 0)
            {
                int id = int.Parse(dataGridView1.CurrentRow.Cells[0].Value.ToString());
                MySqlConnection konekcij = ConnectionPool.checkOutConnection();
                MySqlCommand cm = konekcij.CreateCommand();
                cm.CommandText = "update ski_obuca set Nedostupan=1 where IdObuce=" + id + ";";
                cm.ExecuteNonQuery();
                MessageBox.Show("Uspješno ste obrisali stavku!");
            }
        }
    }
}
