using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.VisualBasic;
using System.Windows.Forms;

namespace IznajmljivanjeSkiOpreme
{
    public partial class ServiserForma : Form
    {
        public static string jmbgserviser = "2211990143304";
        public ServiserForma()
        {
            InitializeComponent();
            this.Activated += new EventHandler(Form1_Activated);
        
        }
        void Form1_Activated(object sender, EventArgs e)
        {
            provjera();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            if (dataGridView1.SelectedRows.Count > 0)
            {
              
                    IstorijaServisa ins = new IstorijaServisa(int.Parse(dataGridView1.CurrentRow.Cells[0].Value.ToString()), dataGridView1.CurrentRow.Cells[1].Value.ToString());
                    ins.Show();
                }
            
            else
                MessageBox.Show("Niste izabrali nijednu stavku !");
        }
        public void provjera()
        {
            MySqlConnection konekcija = ConnectionPool.checkOutConnection();
            MySqlCommand cmd = konekcija.CreateCommand();
            if (radioButton1.Checked) //snowboard
            {
                if (radioButton4.Checked) //dostupan
                {
                    cmd.CommandText= "call dostupniSnowboardiRezervacija(current_date());";
                }
                else //na servisu
                {
                    cmd.CommandText = "SELECT * from snowboardNaServisuDanas";
                }
            }
            else  //skije
            {
                if(radioButton4.Checked) //dostupni
                {
                    cmd.CommandText = "call dostupneSkijeRezervacija(current_date());";
                }
                else   //na servisu
                {
                    cmd.CommandText = "SELECT * from skijeNaServisuDanas;";
                }
            }
            MySqlDataReader read = cmd.ExecuteReader();
            var dataTable = new DataTable();
           dataTable.Load(read);
            dataGridView1.DataSource = dataTable;
            dataGridView1.Columns[0].Visible = false;

        }

        private void ServiserForma_Load(object sender, EventArgs e)
        {
            radioButton1.Checked = true;
            radioButton4.Checked = true;
            MySqlConnection konekcija = ConnectionPool.checkOutConnection();
            MySqlCommand cmd = konekcija.CreateCommand();
            cmd.CommandText = "SELECT Ime from OSOBA where jmbg=" + jmbgserviser;
            MySqlDataReader read = cmd.ExecuteReader();
            while (read.Read())
            {
                label6.Text = read["Ime"].ToString();
            }
            konekcija.Close();
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

        private void radioButton4_CheckedChanged(object sender, EventArgs e)
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
                    MessageBox.Show("Izabrali ste stavku koja je vec na servisu!");
                }
                else
                {
                    NoviServis ns = new NoviServis(int.Parse(dataGridView1.CurrentRow.Cells[0].Value.ToString()), dataGridView1.CurrentRow.Cells[1].Value.ToString(),jmbgserviser,this);
                    ns.Show();
                }
            }
            else
                MessageBox.Show("Niste izabrali nijednu stavku !");
        }

        private void ServiserForma_Enter(object sender, EventArgs e)
        {
          
        }

        private void ServiserForma_Activated(object sender, EventArgs e)
        {
          
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
