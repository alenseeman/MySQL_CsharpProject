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
    public partial class SkiOpremaForma : Form
    {
        public SkiOpremaForma()
        {
            InitializeComponent();
            radioButton1.Checked = true;
            radioButton5.Checked = true;
        }
        public void provjera()
        {
            MySqlConnection konekcija = ConnectionPool.checkOutConnection();
            MySqlCommand cmd = konekcija.CreateCommand();
            if (radioButton5.Checked)
            {
                if (radioButton1.Checked)
                {
                    cmd.CommandText = "SELECT * FROM dostupneSkijeRezervacijaDanas";
                }
                else if (radioButton2.Checked)
                {
                    cmd.CommandText = "SELECT * FROM skijeNaServisuDanas";
                }
                else
                    cmd.CommandText = "SELECT * FROM iznajmljeneSkijeDanas";
            }
            else
            {
                if (radioButton1.Checked)
                {
                    cmd.CommandText = "SELECT * FROM dostupniSnowboardiRezervacijaDanas";
                }
                else if (radioButton2.Checked)
                {
                    cmd.CommandText = "SELECT * FROM snowboardnaservisuDanas";
                }
                else
                    cmd.CommandText = "SELECT * FROM iznajmljeniSnowboardDanas";
            }
            MySqlDataAdapter myAdapter = new MySqlDataAdapter(cmd); // Adapter
            DataSet ds = new DataSet();
            myAdapter.Fill(ds); // DataSet <- Adapter
            dataGridView1.DataSource = ds.Tables[0];
            dataGridView1.Columns[0].Visible = false;
        }
        private void SkiOpremaForma_Load(object sender, EventArgs e)
        {
            provjera();
        }

        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {
          
        }

        private void panel3_Paint(object sender, PaintEventArgs e)
        {

        }

        private void radioButton4_CheckedChanged(object sender, EventArgs e)
        {
            provjera();
        }

        private void radioButton5_CheckedChanged(object sender, EventArgs e)
        {
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
    }
}
